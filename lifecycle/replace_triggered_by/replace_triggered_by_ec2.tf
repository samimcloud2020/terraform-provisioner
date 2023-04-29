# Create a VPC

resource "aws_instance" "web1" {
  ami             = "ami-007855ac798b5175e" 
  instance_type   = "t2.micro"
  key_name        = "bsnl"
  subnet_id       = "subnet-062ac4058a80adee1"
  security_groups = ["sg-040632956d3752c46"]
  
  user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing apache2"
  sudo apt update -y
  sudo apt install apache2 -y
  echo "<h1>welcome apache2 web1 change <\h1>" > /var/www/html/index.html  #as soon as change user_data in web1 , its triggered web2 to change/replacement
  sudo systemctl restart apache2
  echo "*** Completed Installing apache"
  EOF

  tags = {
    Name = "web_instance1"
  }

  volume_tags = {
    Name = "web_instance1"
  } 
}




resource "aws_instance" "web2" {
  ami             = "ami-007855ac798b5175e" 
  instance_type   = "t2.micro"
  key_name        = "bsnl"
  subnet_id       = "subnet-062ac4058a80adee1"
  security_groups = ["sg-040632956d3752c46"]
  lifecycle {
    replace_triggered_by = [
      aws_instance.web1.user_data
    ]
  }  
  user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing apache2"
  sudo apt update -y
  sudo apt install apache2 -y
  echo "<h1>welcome apache2 web2<\h1>" > /var/www/html/index.html
  sudo systemctl restart apache2
  echo "*** Completed Installing apache"
  EOF

  tags = {
    Name = "web_instance2"
  }

  volume_tags = {
    Name = "web_instance2"
  } 
}


