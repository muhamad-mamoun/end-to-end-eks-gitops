resource "kubernetes_secret" "git-creds" {
  metadata {
    name      = "git-creds"
    namespace = kubernetes_namespace.argocd-namespace.metadata[0].name
    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
    }
  }

  data = {
    url      = var.gitops-repo-url
    username = var.github-username
    password = var.github-password
  }

  type = "Opaque"
}

resource "kubectl_manifest" "application-secret-store" {
  yaml_body = <<END
apiVersion: external-secrets.io/v1
kind: ClusterSecretStore
metadata:
  name: app-secretstore
spec:
  provider:
    aws:
      service: SecretsManager
      region: us-east-1
      auth:
        jwt:
          serviceAccountRef:
            name: aws-sm-read-sa
            namespace: eso
  END

  depends_on = [kubernetes_service_account.aws-sm-read-sa]
}

resource "kubectl_manifest" "application-external-secret" {
  yaml_body = <<END
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: app-external-secrets
  namespace: webapp
spec:
  refreshInterval: 1h
  secretStoreRef:
    name: app-secretstore
    kind: ClusterSecretStore
  target:
    name: app-secrets
    namespace: webapp
    creationPolicy: Owner
  dataFrom:
  - extract:
      key: application-secrets
  END

  depends_on = [kubectl_manifest.application-secret-store, kubernetes_namespace.application-namespace]
}
