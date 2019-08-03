#!/usr/bin/env bash

cd terraform
terraform init
terraform taint null_resource.upload_files_s3
terraform plan
terraform apply -auto-approve