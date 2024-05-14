terraform {
  backend "s3" {
    bucket = "state-ram-state"
    key    = "/folder-2/terraform.tfstate"
    region = "ap-south-1"
  }
}