output "ecr-registry-url" {
  value = split("/", aws_ecr_repository.ecr-repositories["frontend"].repository_url)[0]
}

output "ecr-frontend-repo-url" {
  value = aws_ecr_repository.ecr-repositories["frontend"].repository_url
}

output "ecr-backend-repo-url" {
  value = aws_ecr_repository.ecr-repositories["backend"].repository_url
}
