locals {
  widget_definition = [
    {
      height = var.geo.height
      properties = {
        metrics = [
          for container in sort(var.instances) : [
            "AWS/ECS",
            "CPUUtilization",
            "ServiceName",
            container,
            "ClusterName",
            var.ecs_cluster,
          ]
        ]
        period  = var.period
        region  = var.region
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
      width = var.geo.width
      # TODO: Don't set position if no ECS widgets are defined.
      x = 0
      y = 0
    },

    {
      height = var.geo.height
      properties = {
        metrics = [
          for container in sort(var.instances) : [
            "AWS/ECS",
            "MemoryUtilization",
            "ServiceName",
            container,
            "ClusterName",
            var.ecs_cluster,
          ]
        ]
        period  = var.period
        region  = var.region
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
      width = var.geo.width
      # TODO: Don't set position if no ECS widgets are defined.
      x = var.geo.width
      y = 0
    }
  ]
}
