#!/bin/sh 


if (( $# != 2 )); then
    echo "Usage: ${0} <preprod|prod> <region|us-east-1>"
    exit 1
fi

sed -i 's/foobar/'${2}'/g' main.tf

terraform init

terraform workspace list | grep  example-vw-${1}-${2} > /dev/null 

if (( $? != 0 )); then
    terraform workspace new example-vw-${1}-${2}
fi

terraform workspace select example-vw-${1}-${2}

terraform apply -auto-approve -var-file=${1}-${2}.tfvars

sed -i 's/'${2}'/foobar/g' main.tf
