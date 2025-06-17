resource "helm_release" "monitoring" {
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  name       = "monitoring"
  version    = "75.0.0"

  timeout          = 1000
  create_namespace = true
  namespace        = var.prometheus-namespace

  values = [
    templatefile("${path.module}/values/monitoring.yaml", {
      GRAFANA_USERNAME    = var.prometheus-username,
      GRAFANA_PASSWORD    = var.prometheus-password,
      PROMETHEUS_EBS_ZONE = var.prometheus-ebs-zone
    })
  ]

  depends_on = [helm_release.ebs-csi-driver, helm_release.ingress]
}
