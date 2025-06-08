resource "helm_release" "argocd" {
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  name       = "argocd"
  version    = "8.0.15"

  atomic           = true
  cleanup_on_fail  = true
  create_namespace = true
  namespace        = "argocd"

  values = [templatefile("${path.module}/values/argocd.yaml", {
    ARGOCD_ADMIN_PASSWORD = var.argocd-hashed-password
  })]
}
