data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "lms_files" {
  bucket = "casas-lms-files-${data.aws_caller_identity.current.account_id}"

  force_destroy = true

  tags = {
    Name      = "CASAS LMS File Storage"
    Project   = "CASAS Cloud-Based Learning Management System"
    ManagedBy = "Terraform"
  }
}

resource "aws_s3_bucket_public_access_block" "lms_files" {
  bucket = aws_s3_bucket.lms_files.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
