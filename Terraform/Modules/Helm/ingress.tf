resource "helm_release" "ingress" {
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  name       = "ingress-nginx"
  version    = "4.12.2"

  timeout          = 1000
  create_namespace = true
  namespace        = "ingress"

  values = [file("${path.module}/values/ingress.yaml")]
}
