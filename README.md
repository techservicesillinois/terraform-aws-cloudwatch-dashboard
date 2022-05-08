# cloudwatch-dashboard

[![Terraform actions status](https://github.com/techservicesillinois/terraform-aws-cloudwatch-dashboard/workflows/terraform/badge.svg)](https://github.com/techservicesillinois/terraform-aws-cloudwatch-dashboard/actions)

Provides a CloudWatch dashboard to allow monitoring AWS resources. The resources supported consist of:

* Elastic Container Service (ECS) containers.
* Relational Database Service (RDS) instances.

The CloudWatch dashboard widgets for ECS containers consists of two widgets forming a single row:

1. Average CPU utilization (as a percentage) for the specified containers.
2. Average memory utilization (as a percentage) for the specified containers.

The CloudWatch dashboard widgets for RDS instances also consists of two widgets forming a single row:

1.  Average read and write IOPS for the specified RDS instance.
2.  Free storage space for the specified RDS instance.

The X axis range for the CloudWatch dashboard widgets is six hours.

The CloudWatch console allows a user to inspect a widget by enlarging the widget, adjusting ranges and metrics, etc. See [Using Amazon CloudWatch Dashboards](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Dashboards.html) for details.

Example Usage
-----------------

```
module "dashboard" {
  source = "git@github.com:techservicesillinois/terraform-aws-cloudwatch-dashboard"

  dashboard_name = "JRR dashboard"
  
  ecs_cluster = "jrr"
  
  ecs_containers = [
    "jrr-service1",
    "jrr-service2",
    "jrr-service3"
  ]

  rds_free_storage_max = 100 * 1000 * 1000 * 1000   # 100 gb
  rds_iops_max         = 200

  rds_instances = [
    "jrr-db"
  ]
}

```

Argument Reference
-----------------

The following arguments are supported:

* `dashboard_name` - (Required) Dashboard name.

* `ecs_cluster` - (Required) Name of ECS cluster holding the service containers to be monitored.

* `ecs_containers` - (Optional) List of ECS containers to be displayed on dashboard.

* `period` – (Optional) Period plotted by dashboard widgets. The default is 300 (a five-minute period

* `rds_free_storage_max` – (Optional) Maximum free storage value plotted on Y axis. By default, CloudWatch chooses the maximum Y value based on the data values in the period.

* `rds_iops_max` – (Optional) Maximum IOPS value plotted on Y axis. By default, CloudWatch chooses the maximum Y value based on the data values in the period.

* `rds_instances` – (Optional) List of RDS instances to be displayed on dashboard.

Attributes Reference
--------------------

The following attributes are exported:

* `dashboard_arn` – ARN of dashboard provided by this module.
