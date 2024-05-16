resource "aws_instance" "song" {
    ami = "ami-0cc9838aa7ab1dce7"
    instance_type = "t2.micro"
    key_name = "keypair"
    tags = {
      Name="ram"
    }
  
}
resource "aws_s3_bucket" "song" {
    bucket = "fghertyvbnm"
  
}