variable "aws_region" {
description = " the aws region to deploy resources in"
type = string 
default = "us-east-1"
}

variable "instance_type" {
description = "the type of ec2 instance to launch"
type = string
default = "t3.micro"
}

variable "ami_id" {
description = " the ami id for the ec2 instance( Ubuntu 22.04)"
type = string
}
