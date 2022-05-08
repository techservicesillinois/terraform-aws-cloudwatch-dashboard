locals {
  rds_io_metrics      = ["ReadIOPS", "WriteIOPS"]
  rds_storage_metrics = ["FreeStorageSpace"]
}

locals {
  widget_definition_io = [
    for instance in var.instances : {
      height = var.geo.height
      properties = {
        metrics = [
          for metric in local.rds_io_metrics : [
            "AWS/RDS",
            metric,
            "DBInstanceIdentifier",
            instance,
          ]
        ]
        period  = var.period
        region  = var.region
        stacked = false
        stat    = "Average"
        title   = format("RDS IOPS (%s)", instance)
        view    = "timeSeries"
        yAxis = {
          left = {
            max = var.rds_iops_max
            min = 0
          }
        }
      }
    }
  ]
}

locals {
  widget_definition_storage = [
    for instance in var.instances : {
      height = var.geo.height
      properties = {
        metrics = [
          for metric in local.rds_storage_metrics : [
            "AWS/RDS",
            metric,
            "DBInstanceIdentifier",
            instance,
            {
              label = "FreeStorageSpace"
            }
          ]
        ]
        period  = var.period
        region  = var.region
        stacked = false
        stat    = "Average"
        title   = format("RDS free storage (%s)", instance)
        view    = "timeSeries"
        yAxis = {
          left = {
            max = var.rds_free_storage_max
            min = 0
          }
        }
      }
      type  = "metric"
      width = var.geo.width
      # TODO: Don't set position if no RDS widgets are defined.
      x = var.geo.width
      y = var.geo.height
    }
  ]
}
