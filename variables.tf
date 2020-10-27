variable "dashboard_name" {
  type        = string
  description = "Dashboard name"
}

variable "ecs_cluster" {
  type        = string
  description = "ECS cluster"
}

variable "ecs_containers" {
  default     = null
  type        = list(string)
  description = "List of ECS containers to be displayed on dashboard"
}

variable "period" {
  default     = 300
  type        = number
  description = "Period plotted by dashboard widgets"
}

variable "rds_free_storage_max" {
  description = "Maximum free storage value plotted on Y axis"
  type        = number
}

variable "rds_iops_max" {
  description = "Maximum IOPS value plotted on Y axis"
  type        = number
}

variable "rds_instance" {
  default     = null
  type        = string
  description = "RDS instance to be displayed on dashboard"
}
