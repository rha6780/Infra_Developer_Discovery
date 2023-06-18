include {
  path = find_in_parent_folders()
}

dependency "lambda" {
  config_path = "../lambda"
}

inputs = {
  lambda_invoke_arn = dependency.lambda.outputs.lambda_invoke_arn
  lambda_function_name = dependency.lambda.outputs.lambda_function_name
}
