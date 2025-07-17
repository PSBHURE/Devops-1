variable "ec2_instance_type" {
    default = "t2.micro"
    type = string
}

variable "ec2_root_storage_size" {
    default = 10
    type = number
}

variable "ec2_ami_id" {
  default = "ami-021a584b49225376d"
  type = string
}

variable "env" {
  default = "prod"
  type = string
}