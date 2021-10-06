locals {
  postfix = var.name_postfix != "" ? var.name_postfix : random_id.id.hex
  alertmanager = defaults(var.alertmanager, {
    memory       = 128
    docker_image = "prom/alertmanager:v0.23.0"
    config_file  = ""
  })
}

resource "random_id" "id" {
  byte_length = 4
}

variable "cf_space_id" {
  description = "Cloudfoundry SPACE id to use for deploying the alertmanager components."
  type        = string
}

variable "alerts_source_app_id" {
  description = "Cloudfoundry app id that will send the alerts. E.g Thanos, Prometheus.."
  type        = string
}

variable "name_postfix" {
  type        = string
  description = "The postfix string to append to the app names, hostname, etc. Prevents namespace clashes"
  default     = ""
}

variable "teams_incoming_webhook_url" {
  description = "Teams incoming webhook URL"
  default     = ""
  type        = string
}

variable "environment" {
  type        = map(any)
  description = "Pass environment variable to the app"
  default     = {}
}

variable "alertmanager" {
  type = object({
    docker_image    = optional(string)
    memory          = optional(string)
    config_file     = optional(string)
    docker_username = optional(string)
    docker_password = optional(string)
  })
  default = {}
}
