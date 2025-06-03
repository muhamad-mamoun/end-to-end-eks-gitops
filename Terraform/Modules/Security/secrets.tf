resource "aws_secretsmanager_secret" "backend-jwt-secret" {
  name                    = "backend-jwt-secret"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "backend-jwt-secret-value" {
  secret_id     = aws_secretsmanager_secret.backend-jwt-secret.id
  secret_string = var.backend-jwt-secret
}

resource "aws_secretsmanager_secret" "database-root-password" {
  name                    = "database-root-password"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "database-root-password-value" {
  secret_id     = aws_secretsmanager_secret.database-root-password.id
  secret_string = var.database-root-password
}

resource "aws_secretsmanager_secret" "database-username" {
  name                    = "database-username"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "database-username-value" {
  secret_id     = aws_secretsmanager_secret.database-username.id
  secret_string = var.database-username
}

resource "aws_secretsmanager_secret" "database-password" {
  name                    = "database-password"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "database-password-value" {
  secret_id     = aws_secretsmanager_secret.database-password.id
  secret_string = var.database-password
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

