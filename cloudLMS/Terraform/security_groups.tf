resource "aws_security_group" "ec2_sg" {
  name        = "casas-lms-ec2-sg"
  description = "Security group for CASAS LMS EC2"
  vpc_id      = aws_vpc.lms_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "CASAS-LMS-EC2-SG"
    Project   = "CASAS Cloud-Based Learning Management System"
    ManagedBy = "Terraform"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "casas-lms-rds-sg"
  description = "Security group for CASAS LMS RDS"
  vpc_id      = aws_vpc.lms_vpc.id

  ingress {
    description     = "MySQL from EC2"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "CASAS-LMS-RDS-SG"
    Project   = "CASAS Cloud-Based Learning Management System"
    ManagedBy = "Terraform"
  }
}