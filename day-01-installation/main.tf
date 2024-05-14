resource "aws_instance" "name" {
    ami = "ami-013e83f579886baeb"
    instance_type = "t2.micro"
    key_name = "keypair"
    tags = {
      Name="spng"
    }
  
}
resource "aws_s3_bucket" "name" {
  bucket = "sdfghjklcvbnmrtyui"
}