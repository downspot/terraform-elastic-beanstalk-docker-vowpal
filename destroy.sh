#!/bin/sh 


if (( $# != 1 )); then
    echo "Usage: ${0} <preprod|prod>"
    exit 1
fi
    

terraform workspace select example-vw-${1}

terraform destroy -var-file=${1}.tfvars
