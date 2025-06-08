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

variable "eks-ecr-access-role-arn" {
  type = string
}

variable "jenkins-volume-id" {
  type = string
}

variable "application-namespace" {
  type = string
}

variable "application-volume-id" {
  type = string
}
