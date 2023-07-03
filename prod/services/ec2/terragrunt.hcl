include {
  path = find_in_parent_folders()
}

dependency "iam" {
  config_path = "../iam"
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "securitygroup" {
  config_path = "../securitygroup"
}

inputs = {
  developer_discover_profile_name = dependency.iam.outputs.developer_discover_profile.name
  vpc_security_group_id = dependency.securitygroup.outputs.security_group_id
  vpc_id = dependency.vpc.outputs.vpc_id
  vpc_gateway = dependency.vpc.outputs.vpc_gateway
  public_subnet = dependency.vpc.outputs.public_subnet-1
}
