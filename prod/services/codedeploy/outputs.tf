module "ec2" {
  source = "../ec2"
}

module "iam" {
  source = "../iam"
}

output "codedeploy_role_arn" {
  value = module.iam.codedeploy_role_arn
}

output "ec2_arn" {
  value = module.ec2.ec2_arn
}
