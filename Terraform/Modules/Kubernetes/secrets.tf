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
