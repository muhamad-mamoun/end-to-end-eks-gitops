resource "helm_release" "external-secret-operator" {
  repository = "https://charts.external-secrets.io/"
  chart      = "external-secrets"
  name       = "external-secrets-operator"
  version    = "0.17.1-rc1"

  create_namespace = true
  namespace        = "eso"

  values = [file("${path.module}/values/eso.yaml")]
}
