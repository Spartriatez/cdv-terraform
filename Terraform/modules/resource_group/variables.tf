variable "application" {
  type        = string
  description = "Applcation name"
}

variable "environment" {
  type        = string
  description = "Environment type"
}

variable "owner" {
  type        = string
  description = "Owner email"
  default     = "ptrawinski.92@outlook.com"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "prefix" {
  type        = string
  description = "Team prefix"
}
