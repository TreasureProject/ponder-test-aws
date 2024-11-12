variable "application_name" {
  description = "The name of the application"
  type        = string
  default     = "ponder"
}

variable "solution_stack_name" {
  description = "The name of the solution stack"
  type        = string
  default     = "64bit Amazon Linux 2023 v4.3.8 running Docker" #https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platforms-supported.html#platforms-supported.nodejs
}

variable "autoscale_min" {
  description = "The minimum size of autoscaling group"
  type        = number
  default     = 1
}
variable "autoscale_max" {
  description = "The maximum size of autoscaling group"
  type        = number
  default     = 2
}
variable "instance_type" {
  description = "The instance type for the Elastic Beanstalk environment"
  type        = string
  default     = "t3.medium"
}

variable "root_volume_size" {
  description = "The size of the root volume for EC2 instances"
  type        = number
  default     = 50
}

variable "root_volume_type" {
  description = "The type of the root volume for EC2 instances"
  type        = string
  default     = "gp3"
}

variable "autoscale_measure_name" {
  description = "The measure name for autoscaling"
  type        = string
  default     = "CPUUtilization"
}

variable "autoscale_statistic" {
  description = "The statistic for autoscaling"
  type        = string
  default     = "Average"
}

variable "autoscale_unit" {
  description = "The unit for autoscaling"
  type        = string
  default     = "Percent"
}

variable "autoscale_lower_bound" {
  description = "The lower bound for autoscaling"
  type        = number
  default     = 20
}

variable "autoscale_lower_increment" {
  description = "The lower increment for autoscaling"
  type        = number
  default     = -1
}

variable "autoscale_upper_bound" {
  description = "The upper bound for autoscaling"
  type        = number
  default     = 60
}

variable "autoscale_upper_increment" {
  description = "The upper increment for autoscaling"
  type        = number
  default     = 1
}

variable "rolling_update_enabled" {
  description = "Whether rolling updates are enabled"
  type        = bool
  default     = true
}

variable "rolling_update_type" {
  description = "The type of rolling update"
  type        = string
  default     = "Health"
}

variable "updating_min_in_service" {
  description = "The minimum number of instances in service during updates"
  type        = number
  default     = 1
}

variable "updating_max_batch" {
  description = "The maximum number of instances to update in one batch"
  type        = number
  default     = 1
}

variable "healthcheck_url" {
  description = "The URL for health checks"
  type        = string
  default     = "/"
}

variable "application_port" {
  description = "The port on which the application listens"
  type        = number
  default     = 80
}

variable "additional_settings" {
  description = "Additional Elastic Beanstalk settings"
  type        = list(map(string))
  default     = []
}

variable "env_vars" {
  description = "Map of custom ENV variables to be provided to the application"
  type        = map(string)
  default     = {}
}

# variable "scheduled_actions" {
#   description = "List of scheduled actions"
#   type        = list(any)
#   default     = []
# }

variable "region" {
  description = "AWS region"
  type        = string
}

variable "availability_zone_selector" {
  description = "Availability Zone selector"
  type        = string
  default     = "Any 2"
}

# variable "dns_zone_id" {
#   description = "Route53 DNS Zone ID"
#   type        = string
# }

variable "wait_for_ready_timeout" {
  description = "The maximum duration to wait for the Elastic Beanstalk Environment to be in a ready state"
  type        = string
  default     = "15m"
}

variable "environment_type" {
  description = "Environment type, e.g. 'LoadBalanced' or 'SingleInstance'"
  type        = string
  default     = "LoadBalanced"
}

variable "loadbalancer_type" {
  description = "Load Balancer type, e.g. 'application' or 'classic'"
  type        = string
  default     = "application"
}

variable "elb_scheme" {
  description = "Specify `internal` if you want to create an internal load balancer"
  type        = string
  default     = "public"
}

variable "tier" {
  description = "Elastic Beanstalk Environment tier, e.g. 'WebServer' or 'Worker'"
  type        = string
  default     = "WebServer"
}

# variable "version_label" {
#   description = "Elastic Beanstalk Application version to deploy"
#   type        = string
# }

variable "force_destroy" {
  description = "Force destroy the S3 bucket for load balancer logs"
  type        = bool
  default     = false
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "development"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
variable "public_subnet_ids" {
  description = "Public Subnet IDs"
  type        = list(string)
}
variable "private_subnet_ids" {
  description = "Private Subnet IDs"
  type        = list(string)
}
variable "loadbalancer_certificate_arn" {
  description = "Load Balancer Certificate ARN"
  type        = string
  default     = ""
}
variable "loadbalancer_ssl_policy" {
  description = "Load Balancer SSL Policy"
  type        = string
  default     = "ELBSecurityPolicy-TLS13-1-2-FIPS-2023-04"
}
variable "enhanced_reporting_enabled" {
  description = "Enhanced Reporting Enabled"
  type        = bool
  default     = true
}

variable "enable_stream_logs" {
  description = "Enable Stream Logs"
  type        = bool
  default     = true
}


variable "cloudflare_secret_name" {
  description = "CloudFlare API key"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "CloudFlare Zone ID"
  type        = string
}
variable "dns_name" {
  description = "dns name"
  type        = string
}
variable "dns_ttl" {
  description = "dns ttl"
  type        = number
  default     = 1 # Auto
}
variable "cloudflare_proxy_enabled" {
  description = "CloudFlare Proxy Enabled"
  type        = bool
  default     = true
}

variable "ponder_secret_name" {
  description = "ponder Secret Name"
  type        = string
  default     = "ponderEnv"
}
