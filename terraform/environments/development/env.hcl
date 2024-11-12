# Set common variables for the environment. This is automatically pulled in in the root terragrunt.hcl configuration to
# feed forward to the child modules.
locals {

  //////////////////
  //// Shared
  //////////////////

  environment        = "development"
  project_name       = "ponder"
  region             = "us-west-2"
  vpc_id             = "vpc-05dea17836f639205"
  vpc_cidr           = "172.16.0.0/16"
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d"]
  private_subnet_ids = ["subnet-05186ecb62fe89af1", "subnet-043c32417ae1feb44", "subnet-01665c3f2db1ae3ab", "subnet-0d3965b1deaa8c6ed"]
  public_subnet_ids  = ["subnet-07a59be000950d409", "subnet-003404907ebf83dd0", "subnet-09a59b1385bc6e955", "subnet-09e903d06b54b56d7"]

  //////////////////
  //// Elastic Beanstalk
  //////////////////

  ssl_certificate_arn      = "arn:aws:acm:us-west-2:665230337498:certificate/765df216-00a8-4a1e-959a-67b05ab60ba8" #spellcaster scm cert
  cloudflare_zone_id       = "437a7f6f5de5431979d32b9b319e27c6"                                                    #spellcaster.lol
  cloudflare_secret_name   = "cloudFlare/SpellcasterLolDns"
  desired_count            = 1
  autoscaling_min_capacity = 1
  autoscaling_max_capacity = 1
  dns_name                 = "ponder"


  aurora_identifier     = "${local.environment}-${local.project_name}"
  engine_version = "16.2"
  database_name  = "postgres" 
  instances = {
    1 = {
      instance_class          = "db.t4g.medium"
      publicly_accessible     = false
      db_parameter_group_name = "default.aurora-postgresql16"
    }
  }


  //////////////////
  //// Github OIDC
  //////////////////

  iam_role_prefix = "${local.environment}-${local.project_name}"
  github_project  = "TreasureProject/ponder-test-aws" # gitHubOrg/gitHubRepo

}
