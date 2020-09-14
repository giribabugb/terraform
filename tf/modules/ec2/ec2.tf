#webserver security group Creation
resource "aws_security_group" "web-sg" {
  name      =      "web-sg"
  vpc_id    =      var.vpc_id
  dynamic "ingress" {
    for_each    =      var.web_ports
    content {
      from_port =    ingress.value
      to_port   =    ingress.value
      protocol  =     "tcp"
      cidr_blocks =   [  var.ips["my_ip"],   var.ips["default_ip"]   ]
    }
  }
  dynamic "egress" {
    for_each    =      var.web_ports
    content {
      from_port =    egress.value
      to_port   =    egress.value
      protocol  =     "tcp"
      cidr_blocks =   [  var.ips["my_ip"],   var.ips["default_ip"]   ]
    }
  }
  tags       =   local.ec2_common_tags
}

#webserver1 ec2 creation
resource "aws_instance" "web-server" {
  ami           =   data.aws_ami.amis.id
  instance_type =   var.web_instance_type       #lookup( var.instance_type, terraform.workspace ) #depending on workspace, instance type is selected
  count         =   var.web_instance_count
  key_name      =   var.key_pair_name
  tags = {
    Name        =    var.public_server_name # "${var.public_server_name}-${count.index + 1}"
  }
  subnet_id     =     var.pub_subnet_id # aws_subnet.public_subnets[ count.index ].id
  vpc_security_group_ids    =     [ aws_security_group.web-sg.id ]
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("./newkey.pem")
      host = self.public_ip
    }
    inline = [
      "sudo apt update -y",
      "sudo apt install python3-pip -y",
      "sudo pip3 install ansible"
    ]
  }
}
/*
resource "aws_security_group" "db-sg"{
  name = "db-sg"
  vpc_id   = var.vpc_id
  dynamic "ingress" {
    for_each  =  var.db-ports
    content{
      from_port = ingress.value
      to_port   = ingress.value
      protocol  = "tcp"
      cidr_blocks = [ var.ips["my_ip"] ]
    }
  }
  tags = local.ec2_common_tags
}

*/
/*
  provisioner "remote-exec" {
    connection {
      type        =     "ssh"
      user        =     "ec2-user"
      private_key =     file("newkey.pem")
     host        =          self.public_ip
    }
    inline = [
      "sudo touch ~/abc.txt"
    ]
  }
}
resource "aws_eip" "ec2_eip" {
    vpc = true
    tags = {
    Name = "web-server-eip"
  }
}
resource "aws_eip_association" "eipassc" {
    allocation_id  = aws_eip.ec2_eip.id
    instance_id = aws_instance.web-server.id
}
resource "aws_instance" "db-server" {
    ami  = data.aws_ami.amis.id
    instance_type = var.db_instance_type
    key_name = var.key_pair_name
    subnet_id = var.prv_subnet_id
    count = var.db_instance_count
    vpc_security_group_ids  = [ aws_security_group.db-sg.id ]
    tags = {
      Name ="${var.private_server_name}-${count.index + 1}"
    }
}
*/

