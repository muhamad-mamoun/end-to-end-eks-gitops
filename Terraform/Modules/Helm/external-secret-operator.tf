resource "helm_release" "external-secret-operator" {
  repository = "https://charts.external-secrets.io/"
  chart      = "external-secrets"
  name       = "external-secrets-operator"
  version    = "0.17.1-rc1"

  timeout          = 1000
  create_namespace = true
  namespace        = "eso"

  values = [templatefile("${path.module}/values/eso.yaml", {
    SM_READ_ROLE_ARN = var.aws-sm-read-role-arn
  })]
}
