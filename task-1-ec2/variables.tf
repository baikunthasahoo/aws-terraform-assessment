variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "ami_id" {
  description = "Amazon Linux 2023 AMI ID"
  type        = string
}

variable "instances" {
  type = map(object({
    instance_type = string
    volume_type   = string
    volume_size   = number
    iops          = optional(number)
    key_name      = string
    environment   = string
    owner         = string
    protect       = optional(bool, false)
  }))
}