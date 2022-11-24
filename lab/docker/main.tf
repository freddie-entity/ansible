resource "docker_image" "debian_ubuntu" {
  name = "mmumshad/ubuntu-ssh-enabled:latest"
}

resource "docker_container" "debian_ubuntu" {
    count = 2
  image = docker_image.debian_ubuntu.image_id
  name  = "debian_ubuntu_${count.index}"
}