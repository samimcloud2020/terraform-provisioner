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
  availability_zone = var.az["az2"]   #az changed after creation
  
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
    create_before_destroy = true   #create new ins with new az then old ins destroy
  }
  tags = {
    Name = "HelloWorld"
  }
}

