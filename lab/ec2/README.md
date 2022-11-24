# Ansible lab
Debian/Ubuntu container hosts controled by a Ansible container managed node.

https://github.com/jmal98/ansiblecm

docker run -it --rm -v $PWD:/tmp/playbook --entrypoint ansible jmal98/ansiblecm:6.2.0 containers -m ping -i inventory/homelab.txt

docker run -it --rm -v $PWD:/tmp/playbook --entrypoint ansible-playbook jmal98/ansiblecm:6.2.0 containers -i inventory/homelab.txt playbooks/deploy.yaml