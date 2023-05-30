remote_state {
  backend = "s3"

  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket  = "infra-developer-discovery"
    key     = "prod/${path_relative_to_include()}/terraform.tfstate"
    region  = "ap-northeast-2"
    profile = "ddprod"
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = "ap-northeast-2"
}
EOF
}
