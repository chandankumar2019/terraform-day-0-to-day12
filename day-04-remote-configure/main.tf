provider "aws" {
  region = "ap-south-1"
}
resource "aws_instance" "name" {
  ami = "ami-0cc9838aa7ab1dce7"
  instance_type="t2.micro"
  key_name="keypair"
  tags = {
    Name = "song"
  }

}
