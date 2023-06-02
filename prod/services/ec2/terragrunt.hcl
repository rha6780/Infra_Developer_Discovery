include {
  path = find_in_parent_folders()
}

dependency "iam" {
  config_path = "../iam"
}

inputs = {
  developer_discover_profile_name = dependency.iam.outputs.developer_discover_profile.name
}
