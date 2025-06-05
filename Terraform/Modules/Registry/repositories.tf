resource "aws_ecr_repository" "ecr-repositories" {
  for_each             = var.ecr-repositories
  name                 = each.value
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }
}
