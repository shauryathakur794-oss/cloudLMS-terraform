resource "aws_db_subnet_group" "lms_db_subnet_group" {
  name = "casas-lms-db-subnet-group"

  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]

  tags = {
    Name      = "CASAS LMS DB Subnet Group"
    Project   = "CASAS Cloud-Based Learning Management System"
    ManagedBy = "Terraform"
  }
}

resource "aws_db_instance" "lms_database" {
  identifier = "casas-lms-database"

  engine         = "mysql"
  engine_version = "8.0"

  instance_class        = "db.t3.micro"
  allocated_storage     = 20
  max_allocated_storage = 20
  storage_type          = "gp3"

  db_name  = "casaslms"
  username = "admin"
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.lms_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  publicly_accessible = false
  skip_final_snapshot = true
  deletion_protection = false

  backup_retention_period = 0

  tags = {
    Name      = "CASAS LMS MySQL Database"
    Project   = "CASAS Cloud-Based Learning Management System"
    ManagedBy = "Terraform"
  }
}
