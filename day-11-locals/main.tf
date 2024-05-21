locals {
  bucket-name = "${var.layer}-${var.env}-bucket-hydnaresh"
  #bucket-name = "song-ram-bucket-hydnaresh"
  
}

resource "aws_s3_bucket" "box" {
    # bucket = "web-song-bucket"
    # bucket = "${var.layer}-${var.env}-bucket-hyd"
    bucket = local.bucket-name
    tags = {
        # Name = "${var.layer}-${var.env}-bucket-hyd"
        Name = local.bucket-name
        Environment = var.env
    }
    
 
  
}
