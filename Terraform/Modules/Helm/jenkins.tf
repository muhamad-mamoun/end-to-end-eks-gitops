resource "helm_release" "jenkins" {
  repository = "https://charts.jenkins.io/"
  chart      = "jenkins"
  name       = "jenkins"
  version    = "5.8.56"

  cleanup_on_fail  = true
  create_namespace = true
  namespace        = "jenkins"

  values = [
    templatefile("${path.module}/jenkins-values.yaml", {
      JENKINS_USERNAME = var.jenkins-username,
      JENKINS_PASSWORD = var.jenkins-password,
    })
  ]
}
