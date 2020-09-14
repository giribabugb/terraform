#vpc creation
resource "aws_vpc" "myvpc" {
  cidr_block       =       var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = "true"
  tags = merge(
   { Name = var.vpc_name }, local.vpc_common_tags
  )
}

#IGW creation
resource "aws_internet_gateway" "myigw" {
  vpc_id   =  aws_vpc.myvpc.id  # var.vpc_id
  tags   =   merge(
    { Name   = var.igw_name }, local.vpc_common_tags
  )
}

#public subnets creation
resource "aws_subnet" "public_subnets" {
  vpc_id       =     aws_vpc.myvpc.id#var.vpc_id
  cidr_block   =     var.pub_subnet_cidr[count.index]
  availability_zone =  var.azs[count.index]
  map_public_ip_on_launch = "true"
  count = var.public_subnet_count
  tags = {
    Name   =   var.public_sub_names[count.index]
    

  }
}
/*
resource "aws_subnet" "private_subnet" {
    vpc_id    =   var.vpc_id
    cidr_block  =    var.prv_subnet_cidr
    availability_zone  = var.azs
    map_public_ip_on_launch  = "false"
    tags = {
      Name = var.private_sub_names
    }
}
*/
#public route table creation
resource "aws_route_table" "pub_rt" {
  vpc_id      =    aws_vpc.myvpc.id # var.vpc_id
  route {
    cidr_block   =     var.ips["default_ip"]
    gateway_id   =     aws_internet_gateway.myigw.id
  }
  tags = merge( { Name = "Public Roue Table" }, local.vpc_common_tags )
}

/*
resource "aws_route_table" "prv_rt" {
    vpc_id  = var.vpc_id
    route {
      cidr_block  = var.ips["default_ip"]
      gateway_id   =  aws_nat_gateway.myNatGW.id
      }
    tags =   merge (
              {  Name = "Private Route Table"},
              local.vpc_common_tags
         )

}
*/
#public route tables associations
resource "aws_route_table_association" "public_rt_assc" {
  route_table_id   =   aws_route_table.pub_rt.id
  count = length(var.public_sub_names)
  subnet_id  = aws_subnet.public_subnets[count.index].id
  #subnet_id  =  element(aws_subnet.public_subnets.*.id,count.index)
}
/*
resource "aws_route_table_association" "prv_rt_assc" {
    route_table_id  = aws_route_table.prv_rt.id
    subnet_id = aws_subnet.private_subnet.id #var.prv_subnet_id
}
resource "aws_eip" "eip" {
    vpc = "true"
    tags = {
      Name = "natgw-eip"
    }

}
resource "aws_nat_gateway" "myNatGW" {
    allocation_id  = aws_eip.eip.id
    subnet_id   =   aws_subnet.public_subnet.id
}
*/

