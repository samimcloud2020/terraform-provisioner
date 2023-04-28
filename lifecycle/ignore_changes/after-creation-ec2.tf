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
  availability_zone = var.az["az2"]  #initially created as az1 and when then created with az2, no infra change told as changes ignore.
  
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

