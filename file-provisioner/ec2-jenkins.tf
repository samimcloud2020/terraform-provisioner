resource "aws_instance" "webserver" {
  depends_on = [
    aws_security_group.websg
  ]


  # AMI ID [I have used my custom AMI which has some softwares pre installed]
  ami                         = "ami-00874d747dde814fa"
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-062ac4058a80adee1"
  associate_public_ip_address = "true"

  # Keyname and security group are obtained from the reference of their instances created above!
  # Here I am providing the name of the key which is already uploaded on the AWS console.
  key_name = "samim"

  # Security groups to use!
  security_groups = ["${aws_security_group.websg.id}"]

  tags = {
    Name = "Webserver_From_Terraform"
  }

  provisioner "file" {
    source      = "install.sh"
    destination = "/tmp/install.sh"
  }


  # Installing required softwares into the system!
  connection {
    host        = self.public_ip
    type        = "ssh"
    port        = 22
    user        = "ubuntu"
    private_key = file("samim.pem")
    timeout     = "2m"
    agent       = false
  }
  # Code for installing the softwares!
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo sh /tmp/install.sh"



    ]
  }
}
