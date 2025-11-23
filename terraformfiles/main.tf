resource "aws_instance" "test-server" {
  ami                    = "ami-0fa3fe0fa7920f68e_us-east-1"
  instance_type          = "t3.small"
  key_name               = "thetfkey"
  vpc_security_group_ids = ["sg-0b4273bc0b0a56bdf"]

  subnet_id              = "subnet-06434fdca0fcadee0"   # ← ID of an existing subnet in that VPC

  tags = {
    Name = "test-server"
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > inventory"
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i inventory /var/lib/jenkins/workspace/zomatoapp/terraformfiles/ansiblebook.yml"
  }
}
