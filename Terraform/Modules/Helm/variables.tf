variable "aws-profile" {
  type = string
}

variable "cluster-name" {
  type = string
}

variable "cluster-endpoint" {
  type = string
}

variable "cluster-certificate" {
  type = string
}

variable "jenkins-ebs-zone" {
  type = string
}

variable "jenkins-custom-pvc" {
  type = string
}

variable "jenkins-username" {
  type = string
}

variable "jenkins-password" {
  type = string
}

variable "eks-ebs-csi-role-arn" {
  type = string
}
