resource "kubernetes_namespace" "jenkins-namespace" {
  metadata { name = "jenkins" }
}
