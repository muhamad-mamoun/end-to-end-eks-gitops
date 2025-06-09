resource "helm_release" "argocd-image-updater" {
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argocd-image-updater"
  name       = "argocd-image-updater"
  version    = "0.12.2"

  create_namespace = true
  namespace        = "argocd"

  values = [
    templatefile("${path.module}/values/argocd-image-updater.yaml", {
      ARGO_IMAGE_UPDATER_SA = var.argo-image-updater-sa
      REPO_URL              = var.ecr-registry-url
    })
  ]

  depends_on = [helm_release.ingress]
}
