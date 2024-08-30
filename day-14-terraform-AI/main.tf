resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main_vpc"
  }
}
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "subnet1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "subnet2"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "main_igw"
  }
}
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "main_rt"
  }
}

resource "aws_route_table_association" "subnet1_association" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "subnet2_association" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.rt.id
}
resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "main_sg"
  }
}
resource "aws_instance" "jenkins_server" {
  ami           = "ami-066784287e358dad1"  # Replace with a valid AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.sg.id]  # Replace security_groups with vpc_security_group_ids

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y openjdk-11-jdk wget git
              wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
              sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
              sudo apt-get update -y
              sudo apt-get install -y jenkins
              sudo systemctl start jenkins
              curl -fsSL https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
              echo deb https://aquasecurity.github.io/trivy-repo/deb bionic main | sudo tee -a /etc/apt/sources.list.d/trivy.list
              sudo apt-get update -y
              sudo apt-get install trivy -y
              EOF

  tags = {
    Name = "jenkins_server"
  }
}

resource "aws_instance" "tomcat_server1" {
  ami           = "ami-066784287e358dad1"  # Replace with a valid AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet2.id
  vpc_security_group_ids = [aws_security_group.sg.id]  # Replace security_groups with vpc_security_group_ids

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y tomcat9
              EOF

  tags = {
    Name = "tomcat_server1"
  }
}

resource "aws_instance" "tomcat_server2" {
  ami           = "ami-066784287e358dad1"  # Replace with a valid AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet2.id
  vpc_security_group_ids = [aws_security_group.sg.id]  # Replace security_groups with vpc_security_group_ids

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y tomcat9
              EOF

  tags = {
    Name = "tomcat_server2"
  }
}
output "jenkins_public_ip" {
  value = aws_instance.jenkins_server.public_ip
}

output "tomcat1_public_ip" {
  value = aws_instance.tomcat_server1.public_ip
}

output "tomcat2_public_ip" {
  value = aws_instance.tomcat_server2.public_ip
}
