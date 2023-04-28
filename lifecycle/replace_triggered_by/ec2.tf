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
  
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type["us-east-1a"]
  availability_zone = var.az["az2"]
  
  root_block_device {
  volume_size = "${lookup(var.storage_sizes, var.plans["5USD"])}"
   }
  provisioner "local-exec" {
   command = "echo ${self.private_ip} >> private_ip1.txt"
 }

 
  provisioner "local-exec" {
    when    = destroy
    command = "echo 'Destroy-time provisioner'"
    on_failure = continue
  }

   lifecycle {
    ignore_changes = all # list of valus [ ], ignore all parameters which is changing any attribute
  }
  tags = {
    Name = "HelloWorld"
  }
}






resource "aws_instance" "web1" {
  ami             = "ami-016eb5d644c333ccb" 
  instance_type   = "t2.micro"
  key_name        = file(bsnl.pem)
  subnet_id       = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.sg.id]
   lifecycle {
    replace_triggered_by = [
      aws_instance.web1
    ]
  } 
  user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing httpd"
  sudo apt update -y
  sudo apt install httpd -y
  echo "<h1>welcome httpd changed <\h1>" > /var/www/html/index.html
  sudo systemctl restart httpd
  echo "*** Completed Installing httpd"
  EOF

  tags = {
    Name = "web_instance"
  }

  volume_tags = {
    Name = "web_instance"
  } 
}
