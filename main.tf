data "aws_region" "current" {}

locals {
  # Define widget geometry.
  geo = {
    height = 6
    width  = 8
  }
}

module "ecs" {
  source = "./modules/ecs"

  instances   = var.ecs_containers
  period      = var.period
  ecs_cluster = var.ecs_cluster
  region      = data.aws_region.current.name
  geo         = local.geo
}

module "rds" {
  source = "./modules/rds"

  instances            = var.rds_instances
  period               = var.period
  rds_free_storage_max = var.rds_free_storage_max
  rds_iops_max         = var.rds_iops_max
  region               = data.aws_region.current.name
  geo                  = local.geo
}

locals {
  widgets = concat(module.ecs.widget_definition, module.rds.widget_definition)
}

resource "aws_cloudwatch_dashboard" "default" {
  dashboard_name = var.dashboard_name
  dashboard_body = jsonencode(
    {
      start   = "-PT6H"
      widgets = local.widgets
    }
  )
}
