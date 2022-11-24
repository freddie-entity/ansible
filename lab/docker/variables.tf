variable "ansible_user" {
  default = "root"
}

variable "ansible_ssh_pass" {
  default = "Passw0rd"
}

variable "ansible_command" {
  default = "playbooks/deploy-postgres.yaml"
  description = "Command for container lab hosts"
}