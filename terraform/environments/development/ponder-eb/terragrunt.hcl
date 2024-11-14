# Include the root `terragrunt.hcl` configuration. The root configuration contains settings that are common across all
# components and environments, such as how to configure remote state.
include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/ponder-eb"
}

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

inputs = {
  vpc_id                       = local.environment_vars.locals.vpc_id
  public_subnet_ids            = local.environment_vars.locals.public_subnet_ids
  private_subnet_ids           = local.environment_vars.locals.private_subnet_ids
  region                       = local.environment_vars.locals.region
  loadbalancer_certificate_arn = local.environment_vars.locals.ssl_certificate_arn
  cloudflare_secret_name       = local.environment_vars.locals.cloudflare_secret_name
  cloudflare_zone_id           = local.environment_vars.locals.cloudflare_zone_id
  dns_name                     = local.environment_vars.locals.dns_name
  aurora_secret_name           = dependency.aurora.outputs.aurora_secret_name
}

dependency "aurora" {
  config_path = "../ponder-aurora"
}
