# Variable declarations
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "ami" {
  description = "AMI"
  type        = string
  default     = "ami-08d70e59c07c61a3a"
}

variable "instance_type" {
  description = "Instance Type"
  type        = string
  default     = "t2.micro"
}

variable "acl" {
  description = "(Optional) The canned ACL to apply."
  type        = string
  default     = "public-read"
}
