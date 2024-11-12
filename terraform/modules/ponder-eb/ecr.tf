resource "aws_ecr_repository" "ponder" {
  name         = local.name
  force_delete = true
}
