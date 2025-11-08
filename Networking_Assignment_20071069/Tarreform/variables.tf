variable "aws_region" {
  default = "us-east-1"
}

variable "key_name" {
  description = "EC2 SSH Key Pair"
  default     = "mykeypair"
}
