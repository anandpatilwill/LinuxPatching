# Provider configuration
  provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIA2P2M2MWT7DDHHAME"
  secret_key = "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"
}

locals {
  instance_names = [for i in range(1, 3) : "Instance ${i}"]
}

resource "aws_instance" "web_servers" {
  count         = 2
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"
  key_name      = "Server"
  vpc_security_group_ids = ["sg-0d8eadcf483ca836d"]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }

  tags = {
    "Name"        = local.instance_names[count.index]
    "Environment" = "Development"
  }
}

