provider "aws" {
  region = var.region
}

resource "random_id" "bucket_id" {
  byte_length = 6
}

resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "${var.s3_bucket_name}-${var.environment}-${random_id.bucket_id.hex}"

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name        = var.s3_bucket_name
    Environment = var.environment
  }
}
