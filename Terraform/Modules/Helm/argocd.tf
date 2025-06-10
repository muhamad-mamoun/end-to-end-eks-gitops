resource "helm_release" "argocd" {
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  name       = "argocd"
  version    = "8.0.15"

  timeout          = 1000
  create_namespace = true
  namespace        = "argocd"

  values = [templatefile("${path.module}/values/argocd.yaml", {
    ARGOCD_ADMIN_PASSWORD = var.argocd-hashed-password
  })]

  depends_on = [helm_release.ingress]
}
