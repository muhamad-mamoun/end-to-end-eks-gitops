output "jenkins-custom-pvc" {
  value = kubernetes_persistent_volume_claim.jenkins-pvc.metadata[0].name
}
