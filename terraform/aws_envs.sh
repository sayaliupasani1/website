#!/usr/bin/env bash

cat > ~/.aws/credentials << EOL
[default]
aws_access_key_id = ${AWS_ACCESS_KEY}
aws_secret_access_key = ${AWS_SECRET_KEY}
region = ${AWS_DEFAULT_REGION}
EOL