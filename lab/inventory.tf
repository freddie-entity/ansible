resource "local_file" "ansible_inventory" {
  filename = "../inventory/lab"
  content = <<-EOT
    [all]
    %{ for ip in docker_container.debian_ubuntu.*.ip_address ~} 
    ${ip} ansible_host=${ip} ansible_user=${var.ansible_user} ansible_ssh_pass=${var.ansible_ssh_pass} ansible_ssh_connection=ssh
    %{ endfor ~}
  EOT
}
resource "null_resource" "playbook_exec" {
  provisioner "local-exec" {
    working_dir = "${path.module}/../../ansible/"
    # command = "ansible-playbook ../playbooks/deploy-postgres.yaml -i ../inventory/lab" # for valid hosts
    command = "pwd && docker run --rm -v $PWD:/tmp/playbook --entrypoint ansible-playbook jmal98/ansiblecm:6.2.0 -i inventory/lab ${var.ansible_command}"
    interpreter = ["/bin/bash", "-c"]
  }
  depends_on = [docker_container.debian_ubuntu,local_file.ansible_inventory]
}

# resource "local_file" "ansible_inventory" {
#   filename = "../inventory/lab"
#   content = <<-EOT
#     [all]
#     %{ for ip in data.aws_instance.find_instance.*.public_ip ~} 
#     ${ip} ansible_ssh_connection=ssh ansible_user=ubuntu ansible_ssh_private_key_file=./aws.pem ansible_ssh_common_args='-o StrictHostKeyChecking=no'
#     %{ endfor ~}
#   EOT
# depends_on = [data.aws_instance.find_instance]
# }
# resource "null_resource" "playbook_exec" {
#   provisioner "local-exec" {
#     command = "ansible-playbook ../ansible/ec2.yml -i ../ansible/inventory"
#     interpreter = ["/bin/bash", "-c"]
#   }
#   depends_on = [data.aws_instance.find_instance,local_file.ansible_inventory]
# }