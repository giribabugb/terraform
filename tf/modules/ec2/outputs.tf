output "web-server-ips"   {
    value = aws_instance.web-server.public_ip
}
output "web-sg" {
  value = aws_security_group.web-sg.id
}
#output "db-server-ip" {
#  value = aws_instance.db-server.*.private_ip
#}
/*
output "instance_ip_addresses" {
  value = {
    #for instance in aws_instance.servers:
    #  instance.id => instance.private_ip
    for instance in aws_instance.servers :
     instance.id => instance.public_ip
  }
} */
