output "ip" {
value = aws_instance.name.public_ip
description = "calling public ip of ec2 instance"
  
}
output "private_ip" {
    value = aws_instance.name.private_ip
    description = "calling private ip ec2 of ec2 instance"
    sensitive = true
  
}