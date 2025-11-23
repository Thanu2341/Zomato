resource "aws_instance" "test-server" {
  ami                    = "ami-0f3aef0a7902f68e"
  instance_type          = "t3.small"
  key_name               = "thetfkey"
  vpc_security_group_ids = ["sg-0b4273bc0b0a56bdf"]

  tags = {
    Name = "test-server"
  }

  # Write instance IP to an inventory file
  provisioner "local-exec" {
    command = "echo ${self.public_ip} > inventory"
  }

  # Run Ansible playbook using that inventory
  provisioner "local-exec" {
    command = "ansible-playbook -i inventory /var/lib/jenkins/workspace/zomatoapp/terraformfiles/ansiblebook.yml"
  }
}
