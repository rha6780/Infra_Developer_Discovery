resource "aws_codedeploy_app" "developer_discovery" {
  compute_platform = "Server"
  name             = "developer_discovery"

  tags = {
    Name  = "developer_discovery"
    Stage = "prod"
  }
}


resource "aws_codedeploy_deployment_config" "developer_discovery_deployment_config" {
  deployment_config_name = "developer_discovery_deployment_config"

  minimum_healthy_hosts {
    type  = "HOST_COUNT"
    value = 2
  }
}

resource "aws_codedeploy_deployment_group" "developer_discovery_deployment_group" {
  app_name               = aws_codedeploy_app.developer_discovery.name
  deployment_group_name  = "developer_discovery_deployment_group"
  service_role_arn       = var.codedeploy_role_arn
  deployment_config_name = aws_codedeploy_deployment_config.developer_discovery_deployment_config.id

  ec2_tag_filter {
    key   = "filterkey"
    type  = "KEY_AND_VALUE"
    value = "filtervalue"
  }

  trigger_configuration {
    trigger_events     = ["DeploymentFailure"]
    trigger_name       = "deploy-trigger"
    trigger_target_arn = var.ec2_arn
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  alarm_configuration {
    alarms  = ["my-alarm-name"]
    enabled = true
  }
}
