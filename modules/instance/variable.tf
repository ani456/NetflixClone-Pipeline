variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "my-ec2-instance"
}

variable "key_name" {
  description = "Name of an existing EC2 key pair for SSH access (leave empty string if not using SSH)"
  type        = string
  default     = "linux-key"
}
variable "project_name" {
  description = "Name prefix used for tagging and naming resources"
  type        = string
  default     = "netflixclone"
}
