output "ec2_public_ip" {
 # value = aws_instance.my_instance.public_ip        # this is usefull when we create 1 instance
  value = aws_instance.my_instance[*].public_ip     # this is usefull when we create more than 1 instance
}

output "ec2_public_dns" {
  value = aws_instance.my_instance.public_dns
}

output "ec2_private_ip" {
  value = aws_instance.my_instance.private_ip
}