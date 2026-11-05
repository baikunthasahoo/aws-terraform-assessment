variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instances" {
  description = "Configuration for all EC2 instances"

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