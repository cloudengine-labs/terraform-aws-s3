variable "region" {
  description = "Bucket Name"
  type        = string
  default     = "us-west-2"
}

variable "s3_bucket_name" {
  description = "Bucket Name"
  type        = string
  default     = "backend_bucket"
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "dev"
}
