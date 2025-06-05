resource "kubernetes_namespace" "ingress-namespace" {
  metadata { name = "ingress" }
}

resource "kubernetes_namespace" "jenkins-namespace" {
  metadata { name = "jenkins" }
}
