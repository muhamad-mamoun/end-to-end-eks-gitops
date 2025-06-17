resource "kubernetes_persistent_volume" "jenkins-pv" {
  metadata { name = "jenkins-pv" }

  spec {
    capacity                         = { storage = "8Gi" }
    access_modes                     = ["ReadWriteOnce"]
    persistent_volume_reclaim_policy = "Delete"

    persistent_volume_source {
      aws_elastic_block_store {
        volume_id = var.jenkins-volume-id
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

resource "kubernetes_persistent_volume" "application-pv" {
  metadata { name = "application-pv" }

  spec {
    capacity                         = { storage = "8Gi" }
    access_modes                     = ["ReadWriteOnce"]
    persistent_volume_reclaim_policy = "Delete"

    persistent_volume_source {
      aws_elastic_block_store {
        volume_id = var.application-volume-id
        fs_type   = "ext4"
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "application-pvc" {
  metadata {
    name      = "application-pvc"
    namespace = var.application-namespace
  }

  spec {
    access_modes = ["ReadWriteOnce"]
    resources { requests = { storage = "8Gi" } }
    volume_name = kubernetes_persistent_volume.application-pv.metadata[0].name
  }
}

resource "kubernetes_persistent_volume" "prometheus-pv" {
  metadata { name = "prometheus-pv" }

  spec {
    capacity                         = { storage = "8Gi" }
    access_modes                     = ["ReadWriteOnce"]
    persistent_volume_reclaim_policy = "Delete"

    persistent_volume_source {
      aws_elastic_block_store {
        volume_id = var.prometheus-volume-id
        fs_type   = "ext4"
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "prometheus-pvc" {
  metadata {
    name      = "prometheus-pvc"
    namespace = kubernetes_namespace.prometheus-namespace.metadata[0].name
  }

  spec {
    access_modes = ["ReadWriteOnce"]
    resources { requests = { storage = "8Gi" } }
    volume_name = kubernetes_persistent_volume.prometheus-pv.metadata[0].name
  }
}
