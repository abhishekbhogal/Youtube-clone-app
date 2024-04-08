# main.tf

provider "aws" {
  region = "us-west-2"  # Update with your desired region
}

resource "aws_instance" "vm" {
  count         = 2
  ami           = "<enter your desired AMI ID>"  # Update with your desired AMI
  instance_type = "<Enter your desired instance type>"               # Update with your desired instance type
  key_name      = var.key_name             # Update with your SSH key name

  tags = {
    Name = "VM-${count.index + 1}"
  }

  root_block_device {
    volume_size = 25
    volume_type = "gp2"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"               # Update with your SSH user
    private_key = file(var.private_key_path)
    host        = self.public_ip
  }
}

output "public_ips" {
  value = aws_instance.vm[*].public_ip
}
