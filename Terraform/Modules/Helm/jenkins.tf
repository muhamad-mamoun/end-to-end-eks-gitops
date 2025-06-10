resource "helm_release" "jenkins" {
  repository = "https://charts.jenkins.io/"
  chart      = "jenkins"
  name       = "jenkins"
  version    = "5.8.56"

  timeout          = 1000
  create_namespace = true
  namespace        = var.jenkins-namespace

  values = [
    templatefile("${path.module}/values/jenkins.yaml", {
      JENKINS_USERNAME = var.jenkins-username,
      JENKINS_PASSWORD = var.jenkins-password,
      JENKINS_EBS_ZONE = var.jenkins-ebs-zone
    })
  ]

  depends_on = [helm_release.ebs-csi-driver, helm_release.ingress]
}
