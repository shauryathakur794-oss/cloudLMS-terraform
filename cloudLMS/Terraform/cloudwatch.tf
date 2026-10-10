resource "aws_cloudwatch_log_group" "lms_logs" {
  name              = "/casas-lms/application"
  retention_in_days = 7

  tags = {
    Name      = "CASAS-LMS-Logs"
    Project   = "CASAS Cloud-Based Learning Management System"
    ManagedBy = "Terraform"
  }
}
