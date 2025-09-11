variable "server_config" {
  description = "Configuration for web server"
  type = object({
    server_name  = string
    environment  = string
    owner        = string
    project      = string
    cpu_cores    = number
    memory_gb    = number
  })
  default = {
    server_name  = "production-web-server"
    environment  = "production"
    owner        = "Pavel Cherkas"
    project      = "Cloud Infrastructure"
    cpu_cores    = 2
    memory_gb    = 1
  }
}