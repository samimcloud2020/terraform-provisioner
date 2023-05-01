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

resource "aws_autoscaling_schedule" "scale_out_during_morning" {
  count = var.enable_autoscaling ? 1 : 0

  scheduled_action_name  = "scale-out-morning"
  min_size               = 2
  max_size               = 10
  desired_capacity       = 10
  recurrence             = "0 9 * * *"
  autoscaling_group_name = aws_autoscaling_group.asg1.name
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  count = var.enable_autoscaling ? 1 : 0

  scheduled_action_name  = "scale-in-at-night"
  min_size               = 2
  max_size               = 10
  desired_capacity       = 2
  recurrence             = "0 17 * * *"
  autoscaling_group_name = aws_autoscaling_group.asg1.name
}
