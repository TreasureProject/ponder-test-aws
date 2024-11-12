# resource "aws_kms_key" "bidgrid_eb" {
#   description              = "KMS key for Bidgrid backend"
#   deletion_window_in_days  = var.environment == "development" ? 7 : 30
#   enable_key_rotation      = var.enable_key_rotation
#   customer_master_key_spec = var.customer_master_key_spec
#   key_usage                = var.key_usage
#   multi_region             = true
#   tags                     = local.tags
# }


data "aws_secretsmanager_secret" "ponder_secret_key" {
  name = var.ponder_secret_name # As stored in the AWS Secrets Manager
}
data "aws_secretsmanager_secret_version" "ponder_secret_key" {
  secret_id = data.aws_secretsmanager_secret.ponder_secret_key.id
}

