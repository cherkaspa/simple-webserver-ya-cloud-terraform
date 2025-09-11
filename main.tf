
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
    user-data = file("user-data.sh")
  }
}


