# Create a VPC
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


resource "aws_launch_template" "template1" {
  name_prefix   = "template1"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.ins_type[0]
}

resource "aws_autoscaling_group" "asg1" {
  availability_zones = [ var.az["az1"], var.az["az2"], var.az["az3"] ]
  desired_capacity   = 1
  max_size           = 3
  min_size           = 1

  launch_template {
    id      = aws_launch_template.template1.id
    version = "$Latest"
  }
}

locals {   
    today_date = formatdate("YYYY-MM-DD",timestamp())
    min = 0
    max = 1
  }
  resource "aws_autoscaling_schedule" "off" {
      scheduled_action_name  = "off_instance"
      min_size               = local.min
      max_size               = local.max
      desired_capacity       = 0
      start_time             =  "${local.today_date}T23:59:00Z" 
      recurrence             = "0 ${var.hour_to_switch_off} * * *"
      autoscaling_group_name = aws_autoscaling_group.asg1.name
      lifecycle {
        ignore_changes = [start_time]
      }
    }
    
    resource "aws_autoscaling_schedule" "on" {
      scheduled_action_name  = "on_instance"
      min_size               = local.min
      max_size               = local.max
      desired_capacity       = 1
      start_time             =  "${local.today_date}T23:59:00Z" 
      recurrence             = "0 ${var.hour_to_switch_on} * * MON-FRI"
      autoscaling_group_name = aws_autoscaling_group.asg1.name
      lifecycle {
        ignore_changes = [start_time]
      }
    }
