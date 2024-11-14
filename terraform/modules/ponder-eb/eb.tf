module "elastic_beanstalk_application" {
  source = "cloudposse/elastic-beanstalk-application/aws"
  # Cloud Posse recommends pinning every module to a specific version
  version     = "0.12.0"
  name        = var.application_name
  description = "${var.application_name} Elastic Beanstalk Application"
  tags        = local.tags
}

module "elastic_beanstalk_environment" {
  source                     = "cloudposse/elastic-beanstalk-environment/aws"
  version                    = "0.52.0"
  name                       = local.name
  description                = "Bidgrid Elastic Beanstalk Environment"
  region                     = var.region
  availability_zone_selector = var.availability_zone_selector
  //dns_zone_id                = var.dns_zone_id

  wait_for_ready_timeout             = var.wait_for_ready_timeout
  elastic_beanstalk_application_name = module.elastic_beanstalk_application.elastic_beanstalk_application_name
  environment_type                   = var.environment_type
  loadbalancer_type                  = var.loadbalancer_type
  elb_scheme                         = var.elb_scheme
  tier                               = var.tier
  //version_label                      = var.version_label
  force_destroy = var.force_destroy

  instance_type    = var.instance_type
  root_volume_size = var.root_volume_size
  root_volume_type = var.root_volume_type

  autoscale_min             = var.autoscale_min
  autoscale_max             = var.autoscale_max
  autoscale_measure_name    = var.autoscale_measure_name
  autoscale_statistic       = var.autoscale_statistic
  autoscale_unit            = var.autoscale_unit
  autoscale_lower_bound     = var.autoscale_lower_bound
  autoscale_lower_increment = var.autoscale_lower_increment
  autoscale_upper_bound     = var.autoscale_upper_bound
  autoscale_upper_increment = var.autoscale_upper_increment

  vpc_id               = var.vpc_id
  loadbalancer_subnets = var.public_subnet_ids
  application_subnets  = var.private_subnet_ids

  allow_all_egress             = true
  enable_loadbalancer_logs     = false
  s3_bucket_versioning_enabled = true
  # additional_security_group_rules = [
  #   {
  #     type                     = "ingress"
  #     from_port                = 0
  #     to_port                  = 65535
  #     protocol                 = "-1"
  #     source_security_group_id = module.vpc.vpc_default_security_group_id
  #     description              = "Allow all inbound traffic from trusted Security Groups"
  #   }
  # ]
  env_vars = merge(var.env_vars,
    {
      "PONDER_RPC_URL_42161" = local.ponder_rpc_url
      "DATABASE_URL"         = local.aurora_connection_string
  })

  rolling_update_enabled  = var.rolling_update_enabled
  rolling_update_type     = var.rolling_update_type
  updating_min_in_service = var.updating_min_in_service
  updating_max_batch      = var.updating_max_batch

  healthcheck_url  = var.healthcheck_url
  application_port = var.application_port

  solution_stack_name = var.solution_stack_name
  //additional_settings = var.additional_settings
  loadbalancer_certificate_arn = var.loadbalancer_certificate_arn
  loadbalancer_ssl_policy      = var.loadbalancer_ssl_policy
  //extended_ec2_policy_document = data.aws_iam_policy_document.minimal_permissions.json
  prefer_legacy_ssm_policy     = false
  prefer_legacy_service_policy = false
  enhanced_reporting_enabled   = var.enhanced_reporting_enabled
  enable_stream_logs           = var.enable_stream_logs
  keypair                      = module.aws_key_pair.key_name
  //scheduled_actions            = var.scheduled_actions
  tags = local.tags


}

