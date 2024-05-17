provider "aws" {
  access_key =  "AKIA47CRYCRHUMBSWJFO"
  secret_key = "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"
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