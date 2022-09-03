#Создание ВМ (из образа)
resource "yandex_compute_instance" "app" {
  name  = "gitlab-ci"

  labels = {
    tags = "gitlab-ci"
  }
  resources {
    cores  = 2
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id = var.gitlab_image
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.app-subnet.id
    nat       = true
  }


/* # прерываемая ВМ дешевле) */
/*   scheduling_policy { */
/*     preemptible = true */
/*   } */

  
  #Для подключения к ВМ

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
  connection {
    type        = "ssh"
    host        = self.network_interface.0.nat_ip_address
    user        = "ubuntu"
    agent       = false
    private_key = file(var.private_key_path)
  }
}
