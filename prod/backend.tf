# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    bucket  = "infra-developer-discovery"
    key     = "prod/./terraform.tfstate"
    profile = "ddprod"
    region  = "ap-northeast-2"
  }
}
