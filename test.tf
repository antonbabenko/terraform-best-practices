variable "database_settings" {
  description = "Database configuration with optional parameters"
  type = object({
    name               = string
    engine             = string
    instance_class     = string
    backup_retention   = optional(number, 7)
    monitoring_enabled = optional(bool, true)
    tags               = optional(map(string), {})
  })
}

