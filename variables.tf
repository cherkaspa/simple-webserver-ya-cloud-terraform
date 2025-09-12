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

variable "yc_cloud_id" {
  description = "Yandex Cloud Cloud ID"
  type        = string
  sensitive   = true
}

variable "yc_folder_id" {
  description = "Yandex Cloud Folder ID"  
  type        = string
  sensitive   = true
}

variable "zone" {
  description = "Default YC availability zone for deploy server"  
  type        = string
  default     = "ru-central1-a"
}

variable "allow_ports" {
  description = "List of ports to open for server"  
  type        = list
  default     = ["80", "443", "8080", "8443"]
}