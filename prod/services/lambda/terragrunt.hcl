include {
  path = find_in_parent_folders()
}

dependency "iam" {
  config_path = "../iam"
}

dependency "ecr" {
  config_path = "../ecr"
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "securitygroup" {
  config_path = "../securitygroup"
}

inputs = {
  lambda_role_arn = dependency.iam.outputs.lambda_role_arn
  ecr_repository_url = dependency.ecr.outputs.ecr_repository_url
  vpc_id = dependency.vpc.outputs.vpc_id
  vpc_subnet_id = dependency.vpc.outputs.vpc_subnet_first_id
  security_group_id = dependency.securitygroup.outputs.security_group_id
}