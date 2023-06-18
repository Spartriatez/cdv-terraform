variable "prefix" {
  type        = string
  description = "Team prefix"
}

variable "application" {
  type        = string
  description = "Application name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}


variable "owner" {
  type        = string
  description = "Resource owner"
}


variable "app_service_id" {
  type        = string
  description = "(optional) describe your variable"
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "LA Workspace ID"
}

variable "severity" {
  type        = string
  description = "Alert Serverity"
}

variable "threshold" {
  type        = string
  description = "Threshold value"
}

variable "app_service_name" {
  type        = string
  description = "App Service Name"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "critical_ag" {
  type        = string
  description = "Critical Action Group ID"
  default     = null
}

variable "warning_ag" {
  type        = string
  description = "Warning Action Group ID"
  default     = null
}

