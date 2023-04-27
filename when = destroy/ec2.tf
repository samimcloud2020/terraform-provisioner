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
  instance_type = var.instance_type2["us-east-1"]
  availability_zone = var.az[var.region] 

  provisioner "local-exec" {
   command = "echo ${self.private_ip} >> private_ip1.txt"
 }

 
  provisioner "local-exec" {
    when    = destroy
    command = "echo 'Destroy-time provisioner'"
    on_failure = continue
  }


  tags = {
    Name = "HelloWorld"
  }
}

