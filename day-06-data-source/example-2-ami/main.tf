provider "aws" {
  access_key =  ""
  secret_key = ""
   region = "ap-south-1"
  
}
  




data "aws_subnet" "selected" {
  filter {
    name   = "tag:Name"
    values = ["data"]
  }
}

resource "aws_instance" "dev" {
    ami = "ami-0cc9838aa7ab1dce7"
    instance_type ="t2.micro"
    key_name =  "keypair"
    subnet_id = data.aws_subnet.selected.id
    tags = {
      Name="mango"
    }

  
}