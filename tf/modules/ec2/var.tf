variable "key_pair_name" {
  default = "newkey"
  description = "private key pair stored in local machine, used to acess the servers"
}

variable "pub_subnet_id" { }
#variable "prv_subnet_id" { }

variable "vpc_id" { }


variable "ips" {
  default = {
    default_ip = "0.0.0.0/0"
    my_ip      = "1.2.3.4/32"
  }
  description = "ips to be mentioned in security group ingress rules"
}
variable "web_instance_type" {
  default = "t2.micro"
  description = "type of instnace of web server to create"
}
variable "db_instance_type" {
  default = "t2.micro"
  description = "type of instnace of db server to create"
}
variable "web_ports" {
  default = ["80", "443", "22"]
  description = "web ports to be mentioned in web security group"
}

variable "db-ports" {
  default = [ "22"]
  description = "db ports to be mentioned in db security group"
}

variable "public_server_name" {
  default = "Web Server"
  description = "name of public servers"
}
variable "private_server_name" {
  default  =  "db-server"
  description = "name of private servers"
}
variable "web_instance_count" {
  default = "1"
  description = "the number of web instances to create"
}
variable "db_instance_count" {
  default = "1"
  description = "the number fo db instnaces to  create"
}
data "aws_ami" "amis" {
  most_recent  = true
  /*owners  = ["amazon"]
  filter {
    name = "name"
    values  = [ "amzn2-ami-hvm*"]
  }*/
  owners  = ["099720109477"] # Canonical
  filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
}
locals {
  ec2_common_tags = {
    Team       = "DevOps"
    service    = "Ec2"
    Evironment = "Testing"
  }
}
