resource "aws_lb" "lms_alb" {
  name               = "casas-lms-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.ec2_sg.id
  ]

  subnets = [
    aws_subnet.public.id,
    aws_subnet.public_b.id
  ]

  tags = {
    Name      = "CASAS-LMS-ALB"
    Project   = "CASAS Cloud-Based Learning Management System"
    ManagedBy = "Terraform"
  }
}

resource "aws_lb_target_group" "lms_target_group" {
  name     = "casas-lms-targets"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.lms_vpc.id

  target_type = "instance"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "80"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 30
    timeout             = 5
  }

  tags = {
    Name      = "CASAS-LMS-Target-Group"
    Project   = "CASAS Cloud-Based Learning Management System"
    ManagedBy = "Terraform"
  }
}

resource "aws_lb_target_group_attachment" "lms_ec2" {
  target_group_arn = aws_lb_target_group.lms_target_group.arn
  target_id        = aws_instance.lms_server.id
  port             = 80
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.lms_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lms_target_group.arn
  }
}
