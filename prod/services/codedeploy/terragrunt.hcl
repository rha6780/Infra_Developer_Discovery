include {
  path = find_in_parent_folders()
}

dependency "ec2" {
  config_path = "../ec2"
}

dependency "iam" {
  config_path = "../iam"
}

inputs = {
  ec2_arn = dependency.ec2.outputs.ec2_arn
  codedeploy_role_arn = dependency.iam.outputs.codedeploy_role_arn
}
