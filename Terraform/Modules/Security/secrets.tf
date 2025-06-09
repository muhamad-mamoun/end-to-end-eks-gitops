resource "aws_secretsmanager_secret" "application-secrets" {
  name                    = "application-secrets"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "backend-jwt-secret-value" {
  secret_id = aws_secretsmanager_secret.application-secrets.id
  secret_string = jsonencode({
    JWT_SECRET  = var.backend-jwt-secret
    DB_USER     = var.database-username
    DB_PASSWORD = var.database-password
  })
}

resource "aws_secretsmanager_secret" "jenkins-username" {
  name                    = "jenkins-username"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "jenkins-username-value" {
  secret_id     = aws_secretsmanager_secret.jenkins-username.id
  secret_string = var.jenkins-username
}

resource "aws_secretsmanager_secret" "jenkins-password" {
  name                    = "jenkins-password"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "jenkins-password-value" {
  secret_id     = aws_secretsmanager_secret.jenkins-password.id
  secret_string = var.jenkins-password
}

