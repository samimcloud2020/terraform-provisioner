data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_instance" "web1" {
  count = length(var.instance_type1)
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type1[count.index]

  provisioner "local-exec" {
   command = "echo ${self.private_ip} >> private_ip1.txt"
 }
  tags = {
    Name = "HelloWorld ${count.index}"
  }
}

