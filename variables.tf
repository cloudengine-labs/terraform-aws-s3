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
