terraform {
  backend "s3" {
    bucket= "backends3githubactions"
    key = "githubactions.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}