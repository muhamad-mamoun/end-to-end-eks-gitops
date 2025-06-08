resource "helm_release" "ingress" {
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  name       = "ingress-nginx"
  version    = "4.12.2"

  atomic           = true
  cleanup_on_fail  = true
  create_namespace = true
  namespace        = "ingress"
}
