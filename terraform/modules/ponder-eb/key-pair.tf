module "aws_key_pair" {
  source              = "cloudposse/key-pair/aws"
  version             = "0.18.0"
  attributes          = ["ssh", "key"]
  ssh_public_key_path = "${path.module}/" #var.ssh_key_path
  generate_ssh_key    = true
  name                = var.application_name
  tags                = local.tags
}
resource "aws_secretsmanager_secret" "eb_key_pair" {
  name = "${var.application_name}/pem"
  tags = local.tags
}

resource "aws_secretsmanager_secret_version" "eb_key_pair" {
  secret_id     = aws_secretsmanager_secret.eb_key_pair.id
  secret_string = module.aws_key_pair.private_key
}