# Define the AWS provider configuration.
provider "aws" {
  region = "us-east-1"  # Replace with your desired AWS region.
}


resource "aws_key_pair" "example" {
  key_name   = "provisioner"  # Replace with your desired key name
  public_key = file("~/.ssh/id_ed25519.pub") 
}

resource "aws_instance" "server" {
  ami                    = "ami-0bb84b8ffd87024d8"
  instance_type          = "t2.micro"
  key_name      = aws_key_pair.example.key_name
 

  connection {  #here connection block use is to connect to ec2 instance and print or run something
    type        = "ssh"
    user        = "ubuntu"  # Replace with the appropriate username for your EC2 instance
    # private_key = file("C:/Users/veerababu/.ssh/id_rsa")
    private_key = file("~/.ssh/id_ed25519")  #private key path
    host        = self.public_ip
  }

  # local execution procee 
 provisioner "local-exec" {
    command = "touch file500"
   
 }
 
  # File provisioner to copy a file from local to the remote EC2 instance
  provisioner "file" {
    source      = "file10"  # Replace with the path to your local file
    destination = "/home/ubuntu/file10"  # Replace with the path on the remote instance
  }
  # remote execution process g
  provisioner "remote-exec" {
    inline = [
"touch file200",
"echo hello from aws >> file200",
]
 }

}

 