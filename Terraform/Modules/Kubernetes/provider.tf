provider "kubernetes" {
  cluster_ca_certificate = base64decode(var.cluster-certificate)
  host                   = var.cluster-endpoint

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--profile", var.aws-profile, "--cluster-name", var.cluster-name]
  }
}
