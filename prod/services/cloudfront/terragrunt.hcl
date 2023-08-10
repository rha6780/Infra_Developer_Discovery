include {
  path = find_in_parent_folders()
}

dependency "s3" {
  config_path = "../s3"
}


inputs = {
  s3_domain = dependency.s3.outputs.bucket_domain_name
  s3_id = dependency.s3.outputs.bucket_id
}
