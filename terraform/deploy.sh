#!/usr/bin/env bash

terraform init ./terraform
terraform plan ./terraform
terraform apply -auto-approve ./terraform