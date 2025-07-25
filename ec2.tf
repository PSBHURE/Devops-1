#key pair
resource "aws_key_pair" "deployer" {
  key_name = "my_key"
  public_key = file("terra_key_ec2.pub")
}

#VPC & Security group
resource "aws_default_vpc" "default"{
    tags = {
        Name = "Default VPC"
    }
}


resource "aws_security_group" "my_sg" {
    name = "automate-SG"
    description = "This will add a TF generated Security Group"
    vpc_id = aws_default_vpc.default.id   #interpolation

    #inbound rules
    ingress  {
        from_port = 22
        to_port = 22
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH open"
    }

    ingress  {
        from_port = 80
        to_port = 80
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTP open"
    }

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Jenkinss open"
    }

    #outbound rules
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "all access are open"
    }

    tags = {
        Name = "automate-SG"
    }
}
#ec2 instance
resource "aws_instance" "my_instance" {
    #count = 2   # meta argument but this create 2 instance with same name and same type
    for_each = tomap({
        SERVER-1 = "t2.micro",
        SERVER-2 = "t2.medium"
    })           # meta argument this can create 2 instance with diff name with diff type
    
    depends_on = [ aws_security_group.my_sg ]  # meta argument now without this SG created this EC2-instancewill not create

    key_name = aws_key_pair.deployer.key_name
    security_groups = [aws_security_group.my_sg.name]
    instance_type = each.value
    ami = var.ec2_ami_id.default  #ubuntu
    user_data = file("install_nginx.sh") + "\n" + file("aws_cli_install.sh")
                

    root_block_device {
      volume_size = var.env == "prod" ? 20 :var.ec2_root_storage_size
      volume_type = "gp3"
    }
    tags = {
      Name = each.key
    }
  
}