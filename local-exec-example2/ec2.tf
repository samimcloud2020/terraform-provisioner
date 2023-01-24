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

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  provisioner "local-exec" {
   command = "echo 'Creation is successful.' >> creation.txt"
 }

 provisioner "local-exec" {
   when = destroy
   command = "echo 'Destruction is successful.' >> destruction.txt"
 }

  tags = {
    Name = "HelloWorld"
  }
}
