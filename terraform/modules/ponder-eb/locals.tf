data "aws_caller_identity" "current" {}

locals {
  name           = format("%s-%s", var.environment, var.application_name)
  ponder_secrets = jsondecode(data.aws_secretsmanager_secret_version.ponder_secret_key.secret_string)
  ponder_rpc_url = local.ponder_secrets["PONDER_RPC_URL_42161"]
  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
  account_id = data.aws_caller_identity.current.account_id
}


