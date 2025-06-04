variable "eks-control-plane-role-arn" {
  type = string
}

variable "eks-worker-nodes-role-arn" {
  type = string
}

variable "bastion-server-role-arn" {
  type = string
}

variable "eks-control-plane-sg-id" {
  type = string
}

variable "eks-worker-nodes-sg-id" {
  type = string
}

variable "eks-subents-ids" {
  type = set(string)
}

variable "worker-nodes-key-name" {
  type = string
}
