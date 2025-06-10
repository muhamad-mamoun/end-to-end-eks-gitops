resource "kubernetes_namespace" "jenkins-namespace" {
  metadata { name = "jenkins" }
}

resource "kubernetes_namespace" "application-namespace" {
  metadata { name = var.application-namespace }
}
