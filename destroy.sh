#!/bin/sh 


if (( $# != 2 )); then
    echo "Usage: ${0} <preprod|prod> <region|us-east-1>"
    exit 1
fi


sed -i 's/foobar/'${2}'/g' main.tf

terraform init

terraform workspace select example-vw-${1}-${2}

terraform destroy -var-file=${1}-${2}.tfvars

sed -i 's/'${2}'/foobar/g' main.tf
