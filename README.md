# ursa-vw


Deployment process:

Run `terraform init`

Edit `.tfvars` files if need be and run the following:

`./deploy.sh environment` (only preprod and prod are needed).

Answer yes to both questions.


To destroy an environment:

`./destroy.sh environment` (only preprod and prod are needed).

App deployment as of now is through the web UI. Deployment file will be `Dockerrun.aws.json`



### todo

There seems to be be a bug in the way I have SNS section written should not ask for 2 questions per deploy.
