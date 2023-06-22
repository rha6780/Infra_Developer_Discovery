include {
  path = find_in_parent_folders()
}

dependency "ec2" {
  config_path = "../ec2"
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "securitygroup" {
  config_path = "../securitygroup"
}

inputs = {
  ec2_id = dependency.ec2.outputs.ec2_id
  vpc_security_group_id = dependency.securitygroup.outputs.security_group_id
  vpc_id = dependency.vpc.outputs.vpc_id
  vpc_gateway = dependency.vpc.outputs.vpc_gateway
  private_subnet = dependency.vpc.outputs.private_subnet
  public_subnet = dependency.vpc.outputs.public_subnet
}