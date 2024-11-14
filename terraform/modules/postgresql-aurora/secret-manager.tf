resource "aws_secretsmanager_secret" "aurora_secret" {
  name = local.db_secret_name
}

resource "aws_secretsmanager_secret_version" "aurora_secret" {
  secret_id = aws_secretsmanager_secret.aurora_secret.id
  secret_string = jsonencode({
    "dbInstanceIdentifier" = local.name
    "password"             = random_password.master_password.result
    "dbname"               = var.database_name
    "engine"               = "postgres"
    "port"                 = "5432"
    "host"                 = module.aurora.cluster_endpoint
    "username"             = var.master_username
    "connection_string"    = "postgres://${var.master_username}:${random_password.master_password.result}@${module.aurora.cluster_endpoint}:5432/${var.database_name}"
  })
}