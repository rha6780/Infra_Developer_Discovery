include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "securitygroup" {
  config_path = "../securitygroup"
}

inputs = {
  vpc_subnet_id = dependency.vpc.outputs.vpc_subnet_first_id
  vpc_security_group_id = dependency.securitygroup.outputs.security_group_id
  private_subnet = dependency.vpc.outputs.private_subnet
  public_subnet = dependency.vpc.outputs.public_subnet
}
