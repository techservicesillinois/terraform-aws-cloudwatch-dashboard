output "dashboard_arn" {
  value = aws_cloudwatch_dashboard.default.dashboard_arn
}

# TODO: This is for debugging.

#output "ecs_widget_definition" {
# value = local.ecs_widget_definition
#}

# TODO: This is for debugging.

#output "rds_widget_definition" {
# value = local.rds_widget_definition
#}
