# terraform-elastic-beanstalk-docker-vowpal


Deployment process:

Run `terraform init`

Edit `.tfvars` files if need be and run the following:

`./deploy.sh environment` (only preprod and prod, additional environments require `.tfvars` files).

Answer yes to both questions.


To destroy an environment:

`./destroy.sh environment` (only preprod and prod, additional environments require `.tfvars` files).

App deployment as of now is through the web UI. Deployment file will be `Dockerrun.aws.json`
