variable "ssh_key_name" {
  description = "The name of the SSH key pair to use for instances"
  type        = string
  default     = "aws_key_pair"   # Change the key pair name
}

