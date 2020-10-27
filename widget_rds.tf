# TODO: Need to make this work if var.rds_instances is empty.
# TODO: Need to make this work for multiple var.rds_instances.

locals {
  rds_io_metrics     = ["ReadIOPS", "WriteIOPS"]
  rds_memory_metrics = ["FreeStorageSpace"]

  rds_widget_definition = [
    {
      height = local.widget_height
      properties = {
        metrics = [
          for metric in local.rds_io_metrics : [
            "AWS/RDS",
            metric,
            "DBInstanceIdentifier",
            var.rds_instance,
          ]
        ]
        period  = var.period
        region  = data.aws_region.current.name
        stacked = false
        stat    = "Average"
        title   = "RDS IOPS (${var.rds_instance})"
        view    = "timeSeries"
        yAxis = {
          left = {
            max = var.rds_iops_max
            min = 0
          }
        }
      }
      type  = "metric"
      width = local.widget_width
      # TODO: Don't set position if no RDS widgets are defined.
      x = 0
      y = local.widget_height
    },

    {
      height = local.widget_height
      properties = {
        metrics = [
          for metric in local.rds_memory_metrics : [
            "AWS/RDS",
            metric,
            "DBInstanceIdentifier",
            var.rds_instance,
            {
              label = "FreeStorageSpace"
            }
          ]
        ]
        period  = var.period
        region  = data.aws_region.current.name
        stacked = false
        stat    = "Average"
        title   = "RDS free storage (${var.rds_instance})"
        view    = "timeSeries"
        yAxis = {
          left = {
            max = var.rds_free_storage_max
            min = 0
          }
        }
      }
      type  = "metric"
      width = local.widget_width
      # TODO: Don't set position if no RDS widgets are defined.
      x = local.widget_width
      y = local.widget_height
    }
  ]
}
