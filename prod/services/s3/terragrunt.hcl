include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
  s3_vpce_id = dependency.vpc.outputs.s3_vpce_id
}
