terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.15.0"
    }
  }
  backend "s3" {
    bucket = "terraform-statefile-bucket-aws"
    key    = "statefiles/terraform.tfstate"
    region = "us-east-1" 
  }
}