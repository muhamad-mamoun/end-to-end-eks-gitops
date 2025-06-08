resource "kubectl_manifest" "argocd-application" {
  yaml_body = <<END
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: web-app
  namespace: ${kubernetes_namespace.argocd-namespace.metadata[0].name}
  annotations:
    argocd-image-updater.argoproj.io/image-list: frontend=${var.ecr-frontend-repo-url}:v1.x,backend=${var.ecr-backend-repo-url}:v1.x
    argocd-image-updater.argoproj.io/frontend.helm.image-name: frontend.image.repository
    argocd-image-updater.argoproj.io/frontend.helm.image-tag: frontend.image.tag
    argocd-image-updater.argoproj.io/backend.helm.image-name: backend.image.repository
    argocd-image-updater.argoproj.io/backend.helm.image-tag: backend.image.tag
    argocd-image-updater.argoproj.io/write-back-method: git:secret:argocd/git-creds

spec:
  destination:
    namespace: ${kubernetes_namespace.application-namespace.metadata[0].name}
    server: https://kubernetes.default.svc
  
  ignoreDifferences:
    - group: apps
      kind: ControllerRevision

  source:
    path: "."
    repoURL: ${var.gitops-repo-url}
    targetRevision: HEAD
    helm:
      valueFiles:
        - ./custom.yaml

  project: default

  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    END
}
