#create vpc
resource "aws_vpc" "dev" {
 cidr_block = "10.0.0.0/16"
 tags = {
   Name = "sing"
 }
}

#create subnet
resource "aws_subnet" "dev" {
  vpc_id     = aws_vpc.dev.id
  cidr_block = "10.0.0.0/24"
}
#create ig & attach to vpc
resource "aws_internet_gateway" "dev" {
    vpc_id = aws_vpc.dev.id
  
}
#create Rt & configure  Ig (edit routes)
resource "aws_route_table" "dev"{
  vpc_id = aws_vpc.dev.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev.id
  }
}


#subnet association to add into Rt(public) 
resource "aws_route_table_association" "dev" {
  subnet_id      = aws_subnet.dev.id
  route_table_id = aws_route_table.dev.id
}

#create security group
resource "aws_security_group" "dev" {
  vpc_id = aws_vpc.dev.id
  tags = {
    Name = "dev-sg"
  }
  description = "Allow HTTP and SSH traffic via Terraform"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
 
  


#Ec2resource "aws_instance" "dev" {
   resource "aws_instance" "dev" {
    ami = var.ami
    instance_type = var.instance_type
    subnet_id = aws_subnet.dev.id
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.dev.id]
    tags = {
      Name="today"
    }
     
   }