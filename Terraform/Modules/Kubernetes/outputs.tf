output "jenkins-namespace" {
  value = kubernetes_namespace.jenkins-namespace.metadata[0].name
}
