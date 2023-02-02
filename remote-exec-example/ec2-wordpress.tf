resource "aws_instance" "webserver" {

   
  # AMI ID [I have used my custom AMI which has some softwares pre installed]
  ami = "ami-00874d747dde814fa"
  instance_type = "t2.micro"
  subnet_id = subnet-062ac4058a80adee1

  # Keyname and security group are obtained from the reference of their instances created above!
  # Here I am providing the name of the key which is already uploaded on the AWS console.
  key_name = "samim"
  
  # Security groups to use!
  vpc_security_group_ids = vpc-00817a61882d246a5

  tags = {
   Name = "Webserver_From_Terraform"
  }

  # Installing required softwares into the system!
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("samim.pem")
    host = aws_instance.webserver.public_ip
  }

  # Code for installing the softwares!
  provisioner "remote-exec" {
    inline = [
        "sudo yum update -y",
        "sudo yum install php php-mysqlnd httpd -y",
        "wget https://wordpress.org/wordpress-4.8.14.tar.gz",
        "tar -xzf wordpress-4.8.14.tar.gz",
        "sudo cp -r wordpress /var/www/html/",
        "sudo chown -R apache.apache /var/www/html/",
        "sudo systemctl start httpd",
        "sudo systemctl enable httpd",
        "sudo systemctl restart httpd"
    ]
  }
}
