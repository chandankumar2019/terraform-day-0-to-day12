variable "ami" {
    type = string
    default = "ami-013e83f579886baeb"
  
}
variable "instance_type" {
    type = string
    default = "t2.micro"
  
}
variable "testlong" {
    type = list(string)
    default = [ "dev","prod" ]
  
}
resource "aws_instance" "testlong" {
    ami = var.ami
    instance_type = var.instance_type
    for_each = toset(var.testlong)
    tags = {
        Name=each.value
    }
  
}