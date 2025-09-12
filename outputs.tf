// Outputs
output "web_server_public_ip" {
  value = yandex_compute_instance.wedserver.network_interface.0.nat_ip_address
}

output "web_server_private_ip" {
  value = yandex_compute_instance.wedserver.network_interface.0.ip_address
}

output "last_version_image" {
  value = data.yandex_compute_image.ubuntu_2404.name
}
