locals {
  widgets = concat(local.ecs_widget_definition, local.rds_widget_definition)
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
