region = "us-east-1"
tag_env = "preprod"
min_instances = "1"
max_instances = "1"
instance_type = "t2.large"
scale_down_by = "-1"
scale_up_by = "1"
rolling_update = "false"
application_name = "example-vw"
env_name = "preprod"
ec2_role = "EXAMPLE_EC2_ROLE"
vpcid = "vpc-1bab5a7f"
subnetids = "subnet-fc0870c1,subnet-80d7b5f6,subnet-8f04bed7"
elb_subnetids = "subnet-fc0870c1,subnet-8f04bed7,subnet-80d7b5f6"

