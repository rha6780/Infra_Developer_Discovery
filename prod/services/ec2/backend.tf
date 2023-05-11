terraform {
  backend "s3" {
    bucket  = "infra-developer-discovery"
    key     = "prod/services/ec2/terraform.tfstate"
    profile = "ddprod"
    region  = "ap-northeast-2"
  }
}