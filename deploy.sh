#!/bin/sh 


if (( $# != 1 )); then
    echo "Usage: ${0} <preprod|prod>"
    exit 1
fi
    

terraform workspace list | grep  example-vw-${1} > /dev/null 

if (( $? != 0 )); then
    terraform workspace new example-vw-${1}
fi

terraform workspace select example-vw-${1}

terraform apply -auto-approve -var-file=${1}.tfvars
