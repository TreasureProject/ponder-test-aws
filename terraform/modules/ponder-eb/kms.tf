
data "aws_secretsmanager_secret" "ponder_secret_key" {
  name = var.ponder_secret_name # As stored in the AWS Secrets Manager
}
data "aws_secretsmanager_secret_version" "ponder_secret_key" {
  secret_id = data.aws_secretsmanager_secret.ponder_secret_key.id
}

data "aws_secretsmanager_secret" "aurora_secret" {
  name = var.aurora_secret_name # As stored in the AWS Secrets Manager
}
data "aws_secretsmanager_secret_version" "aurora_secret" {
  secret_id = data.aws_secretsmanager_secret.aurora_secret.id
}



