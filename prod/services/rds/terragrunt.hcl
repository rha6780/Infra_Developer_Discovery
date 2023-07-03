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
  db_security_group_id = dependency.securitygroup.outputs.db_security_group_id
  db_subnet_group_name = dependency.vpc.outputs.db_subnet_group_name
}
