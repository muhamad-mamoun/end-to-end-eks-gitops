resource "kubernetes_persistent_volume" "jenkins-pv" {
  metadata { name = "jenkins-pv" }

  spec {
    capacity                         = { storage = "8Gi" }
    access_modes                     = ["ReadWriteOnce"]
    persistent_volume_reclaim_policy = "Delete"

    persistent_volume_source {
      aws_elastic_block_store {
        volume_id = "vol-0648a3c6acb5f8b01"
        fs_type   = "ext4"
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "jenkins-pvc" {
  metadata {
    name      = "jenkins-pvc"
    namespace = kubernetes_namespace.jenkins-namespace.metadata[0].name
  }

  spec {
    access_modes = ["ReadWriteOnce"]
    resources { requests = { storage = "8Gi" } }
    volume_name = kubernetes_persistent_volume.jenkins-pv.metadata[0].name
  }
}
