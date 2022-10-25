provider "aws" {
  region     = "us-east-2"
  access_key = "AKIAZN3BIDBBPUW7SOPI"
  secret_key = "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"
}


terraform {
  backend "s3" {
    bucket = "ookey1"
    key = "mathi/terraform.tfstate"
    region = "us-east-2"
    access_key = "AKIAZN3BIDBBPUW7SOPI"
    secret_key = "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"
    dynamodb_table = "ookey"
  }
}