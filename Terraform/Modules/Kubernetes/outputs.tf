output "jenkins-custom-pvc" {
  value = kubernetes_persistent_volume_claim.jenkins-pvc.metadata[0].name
}

output "argo-image-updater-sa" {
  value = kubernetes_service_account.aws-ecr-read-sa.metadata[0].name
}
