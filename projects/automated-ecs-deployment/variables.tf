variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
variable "ecr_image_uri" {
  description = "The full URI of the Docker image in ECR"
  type        = string
}
