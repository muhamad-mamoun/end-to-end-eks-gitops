resource "aws_ecr_repository" "ecr-repositories" {
  for_each             = var.ecr-repositories
  name                 = each.value
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
