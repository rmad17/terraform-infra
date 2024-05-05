
resource "aws_security_group" "asg_sg" {
  name        = "asg_sg"
  description = "Security Group ASG"

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_template" "ec2_ubuntu" {
  name_prefix   = "tf_asg"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.asg_sg.id]
}

resource "aws_autoscaling_group" "asg-group" {
  availability_zones = ["ap-south-1a"]
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1
  launch_template {
    id      = aws_launch_template.ec2_ubuntu.id
    version = "$Latest"
  }
}

resource "aws_lb_target_group" "tf-alb-tg" {
  name        = "tf-alb-tg"
  target_type = "alb"
  port        = 80
  protocol    = "TCP"
}
