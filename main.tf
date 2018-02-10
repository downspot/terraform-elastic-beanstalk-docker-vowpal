variable "region" {}
variable "application_name" {}
variable "min_instances" {}
variable "max_instances" {}
variable "instance_type" {}
variable "scale_down_by" {}
variable "scale_up_by" {}
variable "rolling_update" {}
variable "vpcid" {}
variable "subnetids" {}
variable "elb_subnetids" {}
variable "tag_env" {}
variable "env_name" {}
variable "ec2_role" {}

data "aws_caller_identity" "current" {}

data "terraform_remote_state" "network" {
  backend 	= "s3"
  workspace   	= "${terraform.workspace}"

  config {
    bucket 	= "example-terraform"
    key   	= "terraform.tfstate"
    region 	= "${var.region}"
  }
}

terraform {
  backend "s3" {
    bucket  = "example-terraform"
    key       = "terraform.tfstate"
    region   = "us-east-1"
  }
}

provider "aws" {
  region = "${var.region}"
}

resource "aws_sns_topic" "health_updates" {
  name = "${var.application_name}-${var.env_name}"
}

resource "aws_sns_topic_subscription" "health_updates_sns" {
  topic_arn                       = "arn:aws:sns:${var.region}:${data.aws_caller_identity.current.account_id}:${var.application_name}-${var.env_name}"
  protocol                        = "lambda"
  endpoint                        = "arn:aws:lambda:${var.region}:${data.aws_caller_identity.current.account_id}:function:example-sns"
  raw_message_delivery            = "false"
}

resource "aws_elastic_beanstalk_environment" "example-vw" {
  name                = "${var.application_name}-${var.env_name}"
  application         = "${var.application_name}"
  solution_stack_name = "64bit Amazon Linux 2017.09 v2.8.4 running Multi-container Docker 17.09.1-ce (Generic)"
  tier                = "WebServer"

  tags {
    ProductCode = "PRD00001453"
    InventoryCode = "example-beanstalk"
    Environment = "${var.tag_env}"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = "${var.min_instances}"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = "${var.max_instances}"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = "URSA"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "${var.ec2_role}"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "${var.instance_type}"
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "LowerBreachScaleIncrement"
    value     = "${var.scale_down_by}"
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "UpperBreachScaleIncrement"
    value     = "${var.scale_up_by}"
  }

  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "RollingUpdateEnabled"
    value     = "true"
  }

  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "RollingUpdateType"
    value     = "Health"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = "${var.vpcid}"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "${var.subnetids}"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = "${var.elb_subnetids}"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = "internal"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = "false"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application"
    name      = "Application Healthcheck URL"
    value     = "TCP:26542"
  }

  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "DeploymentPolicy"
    value     = "Rolling"
  }

  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "Timeout"
    value     = "3600"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "LoadBalanced"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = "aws-elasticbeanstalk-service-role"
  }

  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }

  setting {
    namespace = "aws:elb:listener:26542"
    name      = "InstancePort"
    value     = "26542"
  }

  setting {
    namespace = "aws:elb:listener:26542"
    name      = "InstanceProtocol"
    value     = "TCP"
  }

  setting {
    namespace = "aws:elb:listener:26542"
    name      = "ListenerProtocol"
    value     = "TCP"
  }

  setting {
    namespace = "aws:elasticbeanstalk:sns:topics"
    name      = "Notification Topic ARN"
    value     = "arn:aws:sns:${var.region}:${data.aws_caller_identity.current.account_id}:${var.application_name}-${var.env_name}"
  }

  setting {
    namespace = "aws:elb:listener:26542"
    name      = "ListenerProtocol"
    value     = "TCP"
  }
}
