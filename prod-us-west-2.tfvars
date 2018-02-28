region = "us-west-2"
tag_env = "prod"
min_instances = "1"
max_instances = "1"
instance_type = "t2.large"
scale_down_by = "-1"
scale_up_by = "1"
rolling_update = "false"
application_name = "example-vw"
env_name = "prod"
ec2_role = "EXAMPLE_EC2_ROLE"
vpcid = "vpc-422f4b27"
subnetids = "subnet-53cf0137,subnet-5cd83b2a,subnet-3de3dc64"
elb_subnetids = "subnet-53cf0137,subnet-5cd83b2a,subnet-3de3dc64"
solution_stack_name = "64bit Amazon Linux 2017.09 v2.8.4 running Multi-container Docker 17.09.1-ce (Generic)"
