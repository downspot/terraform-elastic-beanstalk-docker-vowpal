# terraform-elastic-beanstalk-docker-vowpal


Deployment process:

Edit `Dockerrun.aws.json` if need be and upload to `s3://example-terraform/example-vw/<region id>` before deploying. 

Edit `.tfvars` files if need be and run the following.

`./deploy.sh environment region`


To destroy an environment:

`./destroy.sh environment region`

App deployment as of now is through the web UI. Deployment file will be `Dockerrun.aws.json`

NOTE: init process might ask for migration verification, answer yes 
