

variable "cluster_name" {
  default = "eks-cluster-testing"
}

variable "pub_subnet_id" { }##gets input from main.tf file 

variable "instance_type" {
  default = "t2.micro"
}


variable "desired_size" {
    default = "1"
}

variable "min_size" {
  default = "1"
}
variable "max_size" {
  default = "1"
}
variable "node_group_name" {
  default =  "eks-node-group-1"
}
variable "cluster_sg_id" {
  default = ""
}



