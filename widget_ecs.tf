# TODO: Need to make this work if var.ecs_containers is empty.

locals {
  ecs_widget_definition = [
    {
      height = local.widget_height
      properties = {
        metrics = [
          for container in sort(var.ecs_containers) : [
            "AWS/ECS",
            "CPUUtilization",
            "ServiceName",
            container,
            "ClusterName",
            var.ecs_cluster,
          ]
        ]
        period  = var.period
        region  = data.aws_region.current.name
        stacked = false
        stat    = "Average"
        title   = "ECS CPU utilization"
        view    = "timeSeries"
        yAxis = {
          left = {
            # For percent values, we want Y-axis to range between 0 and 100.
            max = 100
            min = 0
          }
        }
      }
      type  = "metric"
      width = local.widget_width
      # TODO: Don't set position if no ECS widgets are defined.
      x = 0
      y = 0
    },

    {
      height = local.widget_height
      properties = {
        metrics = [
          for container in sort(var.ecs_containers) : [
            "AWS/ECS",
            "MemoryUtilization",
            "ServiceName",
            container,
            "ClusterName",
            var.ecs_cluster,
          ]
        ]
        period  = var.period
        region  = data.aws_region.current.name
        stacked = false
        stat    = "Average"
        title   = "ECS memory utilization"
        view    = "timeSeries"
        yAxis = {
          left = {
            # For percent values, we want Y-axis to range between 0 and 100.
            max = 100
            min = 0
          }
        }
      }
      type  = "metric"
      width = local.widget_width
      # TODO: Don't set position if no ECS widgets are defined.
      x = local.widget_width
      y = 0
    }
  ]
}
