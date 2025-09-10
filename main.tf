terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = "ru-central1-a"
}

resource "yandex_vpc_network" "web" {
  name = "web-network"
}

resource "yandex_vpc_subnet" "web_subnet" {
  name           = "web-subnet"
  network_id     = yandex_vpc_network.web.id
  v4_cidr_blocks = ["10.1.10.0/24"]
}

resource "yandex_vpc_security_group" "web_sg" {
  name        = "wed-security-group"
  network_id  = yandex_vpc_network.web.id

  ingress {
    protocol       = "TCP"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    port           = 443
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  
  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_compute_instance" "wedserver" {
  name        = "web-server"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"
   
  scheduling_policy {
    preemptible = true
  }

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      type     = "network-ssd"
      image_id = "fd888dplf7gt1nguheht"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.web_subnet.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.web_sg.id]
  }

  metadata = {
    user-data = <<EOF
#!/bin/bash
apt update -y
apt install nginx -y
myip=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
myip_pub=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
echo "<h2>WebServer with IP:<br>Private:$myip<br>Public:$myip_pub</h2><br>Build by Terraform using External Script!" > /var/www/html/index.html
systemctl enable nginx
systemctl start nginx
EOF
  }
}

// Outputs
output "web_server_public_ip" {
  value = yandex_compute_instance.wedserver.network_interface.0.nat_ip_address
}

output "web_server_private_ip" {
  value = yandex_compute_instance.wedserver.network_interface.0.ip_address
}


