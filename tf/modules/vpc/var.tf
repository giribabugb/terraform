
#variable "vpc_id" { }

#variable "pub_subnet_id" { }

#variable "prv_subnet_id" { }

variable "vpc_name" {
  default = "Custom_VPC"
}
variable "igw_name" {
  default = "Custom VPC-IGW"
}

variable "vpc_cidr" {
  default = "10.2.0.0/16"
  description = "vpc is created with this cidr block defined"
}

variable "pub_subnet_cidr" {
  default = ["10.2.1.0/24", "10.2.2.0/24"]
  description = "public subnet is created with this defined network"
}
variable "prv_subnet_cidr" {
  default = "10.1.3.0/24"
  description = "private subnet is created with this defined network"
}

variable "azs" {
  default = ["us-east-1a", "us-east-1b"]
  description = "availability zones on which the public and private subnets created"
}

variable "public_subnet_count" {
  default = "2"
}



variable "public_sub_names" {
  default = ["pub-subnet-1", "pub-subnet-2"]
  description = "name of public subnet"
}
variable "private_sub_names" {
  default = "Main Private Subnet"
  description = "name of private subnet"
}


variable "ips" {
  default = {
    default_ip = "0.0.0.0/0"
  }
  description = "ip to define routing in  route tables"
}


locals {
  vpc_common_tags = {
    Team        = "DevOps"
    service     = "VPC"
    Environment = "Temp"
  }
}
