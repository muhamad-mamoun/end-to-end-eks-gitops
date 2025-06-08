resource "helm_release" "jenkins" {
  repository = "https://charts.jenkins.io/"
  chart      = "jenkins"
  name       = "jenkins"
  version    = "5.8.56"

  atomic           = true
  cleanup_on_fail  = true
  create_namespace = true
  namespace        = "jenkins"

  values = [
    templatefile("${path.module}/values/jenkins.yaml", {
      JENKINS_USERNAME = var.jenkins-username,
      JENKINS_PASSWORD = var.jenkins-password,
      JENKINS_PVC      = var.jenkins-custom-pvc,
      JENKINS_EBS_ZONE = var.jenkins-ebs-zone
    })
  ]
}
