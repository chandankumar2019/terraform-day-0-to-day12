# Another provider alias 
provider "aws" {
    region = "us-east-1"
    alias = "america" 
}


resource "aws_s3_bucket" "test" {
    bucket = "my-multiprovider-bucket-1"
}



resource "aws_s3_bucket" "test2" {
    bucket = "my-multiprovider-bucketr-2"
    provider = aws.america
    #provider.value of alias
  
}