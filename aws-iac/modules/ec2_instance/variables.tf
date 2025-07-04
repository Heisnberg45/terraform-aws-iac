variable "instance_name" {
  description = "Name of the instance"
  type        = string
}

variable "ami_id" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "key_name" {
  description = "SSH key name to attach to the EC2 instance"
  type        = string
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
}
