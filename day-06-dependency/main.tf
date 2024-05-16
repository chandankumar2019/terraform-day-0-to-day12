resource "aws_instance" "ram" {
    ami = "ami-0cc9838aa7ab1dce7"
    instance_type ="t2.micro"
    key_name =  "keypair"
    tags = {
      Name="mitha"
    }

  
}
resource "aws_s3_bucket" "box" {
    bucket = "dfghjrtyuivbn"
    depends_on = [ aws_instance.ram ]
  
}