---
title: "Create your website using Terraform"
date: 2019-08-02
hero: /images/posts/tech-blogs/terraform.png
author: "Sayali Upasani"
menu:
  sidebar:
    name: Technical Blogs
    identifier: writing-post-md-guide
    parent: tech-blogs
    weight: 30
---

Hi ..

This is a post on how I automated the process of building, testing and deploying my website using [Terraform](https://www.terraform.io/) and [TravisCI](https://travis-ci.com/).

For readers who came for code, I don't want you to spend time scrolling all the way.. so, you can find my github link here:
[github:website](https://github.com/sayaliupasani1/website)

Why am I writing this blog? Well, to be honest.. this is my first blog and I feel this urge to jot down the entire process of deploying your website into well-defined words because it's worth it! As a beginner (and not a web-developer), creating and deploying websites may seem really daunting.. I have done this before but never really learnt the ropes of how people find time and strength to maintain their site!

Recently, I started playing around with Terraform and soon enough decided to deploy my website in a codified manner.
So without much further ado, let me start with how I did this, what caveats I faced and what are the loopholes that still needs to be addressed and I hope this blog helps you navigate the maze <i class="fas fa-smile"></i>

### What's the outcome?

The idea was to codify my personal website, meaning, this the end result I expected (and its in place now <i class="fas fa-grin-wink"></i>)

Here is the flow and a general glimpse of what all this is about:

<img src="/images/website-terraform.png" alt="FlowChart"
	title="Pipeline" width="720" height="600" />

### Lets breakdown:

Things you need in place before you can start your terraform deployment:

1) Have your AWS account.

2) Its preferred to create an IAM user inorder to do any deployments/changes.
When you do so, you need to save your AWS IAM user's access key and secret key. Its used for performing any programmatic access to your AWS services.

3) Register the domain name on AWS Route53. It will create a hosted zone for this domain automatically.
If you already have the domain, you need to migrate it to Amazon. You can refer their documentation for the same.

 > Yes, you do need to migrate your domain to Amazon if you wish to use alias records (required for CloudFront distribution's caching and SSL abilities).

4) Import your certificate or create one (and get it signed by ACMPCA) using Amazon's ACM service.
This will be required to configure SSL (to get that pretty green lock <i class="far fa-smile-wink"></i> ) on your website using Amazon's CloudFront distribution.

5) Ensure to have a Github account and a dedicated repo for this project.

6) Create an account on TravisCI and sync your Github account with it.

That's it.. let's dig into terraform files now!

###### Understanding Terraform resources:

1. Creating s3 bucket

``` yaml
#-------terraform/main.tf----------
// This terraform resource creates an s3 bucket with static web hosting

resource "aws_s3_bucket" "website_s3" {
	bucket = "www.${var.domain_name}"
	acl    = "public-read"

// AWS recommends creating a security policy even if you have an ACL set.

	policy = <<POLICY
{
 	"Id": "Policy1564634274590",
  	"Version": "2012-10-17",
     "Statement": [
        {
           "Sid": "Stmt1564634270138",
            "Action": ["s3:GetObject"],
            "Effect": "Allow",
            "Resource": "arn:aws:s3:::www.sayaliupasani.com/*",
            "Principal": "*"
         }
     ]
 }
 POLICY
// Configuring static web hosting on this bucket.

 	website {
 	  index_document ="index.html"
 	  error_document ="404.html"
 	}

	tags = {
	  Name = "Website_bucket"
	}
}
```

2.  Uploading website content to S3 bucket

```yaml
#-------terraform/main.tf---------
// Create a null resource to run aws s3 sync command (using local-exec provisioner) that pushes your public folder

resource "null_resource" "upload_files_s3" {
	provisioner "local-exec" {
	  command = "aws s3 sync ${path.cwd}/../public s3://${aws_s3_bucket.website_s3.id}"
	}
}

// Deleting of files only on terraform destroy

resource "null_resource" "delete_files_s3" {
	provisioner "local-exec" {
	  when    = "destroy"
	  command = "aws s3 rm s3://${aws_s3_bucket.website_s3.id} --recursive"
```

Terraform has this local-exec provisioner, which can be used to execute commands on the host machine. 

> As per my research, you can achieve this upload of file using AWS lambda.. I guess I am going to give it a try soon <i class="far fa-grin-beam-sweat"></i>!

3. Configuring AWS CloudFront distribution

Why use this? In a nutshell - to speed up the content distribution to your users since Amazon Cloudfront delivers your content through worldworld network of data centers, use SSL and save cost since a lot of user requests will be served by CloudFront's cache!

To use CloudFront, we need a certificate in your ACM. You need to have this certificate in place. Using Terraform, we will create a data resource for this existing certificate and use it in our cloudFront distribution.

```yaml
#-------terraform/main.tf-----------
// data resource will not create any resource. It will only allow data to be fetched regarding specified resource

data "aws_acm_certificate" "site_cert" {
	domain = "${var.domain_name}"
	statuses = ["ISSUED"]
}

// Cloudfront configuration is pretty much left to defaults required while creating one

resource "aws_cloudfront_distribution" "site_distribution" {
 	origin {

 	  custom_origin_config {
 	    http_port              = "80"
 	    https_port             = "443"
 	    origin_protocol_policy ="http-only"
 	    origin_ssl_protocols   =["TLSv1", "TLSv1.1", "TLSv1.2"]
 	  }

// specify your s3 bucket's endpoint as origin of your data. This is where your cloudfront distribution will fetch the non-cached data from.

 	  domain_name = "${aws_s3_bucket.website_s3.website_endpoint}"
 	  origin_id = "${var.domain_name}"
 	}
 	enabled             = true
 	#retain_on_delete    = true
 	default_root_object = "index.html"

 	default_cache_behavior {

 	  viewer_protocol_policy = "redirect-to-https"
 	  allowed_methods  = ["GET", "HEAD"]
 	  cached_methods   = ["GET", "HEAD"]
 	  target_origin_id = "${var.domain_name}"

 	  forwarded_values {
 	    query_string = false
 	    cookies {
 	      forward = "none"
 	    }
 	  }
 	}
 	aliases = ["${var.domain_name}"]

// Specify the certificate using above data resource

 	viewer_certificate {
 	  acm_certificate_arn = "${data.aws_acm_certificate.site_cert.arn}"
 	  ssl_support_method  = "sni-only"
 	}

 	restrictions {
 	  geo_restriction {
 	    restriction_type = "none"
 	  }
 	}
}
```

4. Creating Route53 A records for your domain. I have used the existing hosted zone.. Again referencing it via data resource.

```yaml
#---------terraform/main.tf--------
data "aws_route53_zone" "hosted-zone" {
	name = "${var.domain_name}"
}
// alias block specifies that this is an alias record - in aws terms, it means that when the traffic comes for this record, Route53 needs to know that it routes to one of the AWS services - in our case .. Cloudfront distribution.

resource "aws_route53_record" "root_record" {
	zone_id = "${data.aws_route53_zone.hosted-zone.zone_id}"
	name    = ""
	type    = "A"

	alias {
	  name                    = "${aws_cloudfront_distribution.site_distribution.domain_name}"
	  zone_id                 = "${aws_cloudfront_distribution.site_distribution.hosted_zone_id}"
	  evaluate_target_health  = false
	}
}
```

5. Creating s3 backend resource

This is optional and you can perfectly execute your Terraform file without this.
However, it becomes a must if you have multiple developers working on the same infrastructure and they all need to maintain and be aware of current terraform state.
For eg, Lets say that Alice and Bob are working on deploying their company's website on AWS s3. Alice adds an s3 bucket creation block and deploys it successfully. Now, if Bob is working on uploading file, his host must be aware of current terraform state.
In circumstances like this, people prefer storing this state remotely.. for instance on an s3 bucket.
If you plan to have a CI/CD pipeline, this is a mandatory step!

Below is the one-time step you need to perform in order to setup a remote state backend for your terraform project:

> You can have below code in a separate .tf file and setup your remote state backend.

```yaml
#-------terraform/remote_state/remote-state.tf ------
provider "aws" {
	region     = "${var.region}"
	access_key = "${var.aws_access_key}"
	secret_key = "${var.aws_secret_key}"
}

# Create an S3 bucket to store the state file

resource "aws_s3_bucket" "terraform_state_store" {
	bucket = "sayaliupasani-terra-state"

	versioning {
		enabled = true
	}
}

# Create dynamodb for locking the state file

resource "aws_dynamodb_table" "dynamodb_terraform" {
	name = "sayaliupasani-terra-db"
	hash_key = "LockID"
	read_capacity = 20
	write_capacity = 20

	attribute {
		name = "LockID"
		type = "S"
	}
}
```
DynamoDB is used to achieve state locking so that only one developer can make changes at any given instance.

6. Once you have your remote s3 backend set, you need below block of code to ensure that the terraform remote state gets updated based on the changes/deployments you perform.

```yaml
#------- terraform/main.tf ------------
// You can enable encryption of data at rest.
terraform {
	backend "s3" {
		bucket = "sayaliupasani-terra-state"
		encrypt = true
		region = "us-east-1"
		key = "terraform.tfstate"
		dynamodb_table = "sayaliupasani-terra-db"
	}
}
```
7. You need to set variables used in your main.tf.

```yaml
#-----terraform/variables.tf------
#variable "aws_access_key" {}

#variable "aws_secret_key" {}

variable "region" {
	default = "us-east-1"
}

variable "domain_name" {
	default = "sayaliupasani.com"
}
```
Its advisable to not set your aws access and secret key values within files that are publicaly accesible. You can define them as variables in variables.tf and pass the values in separate terraform.tfvars file.

The other option is to set the values as enviroment variables:

```bash
export AWS_ACCESS_KEY_ID=<VALUE>
export AWS_SECRET_ACCESS_KEY=<VALUE>
export AWS_DEFAULT_REGION=<VALUE>
```

Well that's pretty much what you need to deploy your website using Terraform. Once you have above files in place... proceed to below magical commands:

```bash
terraform init
terraform plan
terraform apply
```

Enjoy!!

Do you wish to automate your deployments on any susequent content updates? You can do so with TravisCI.

### Understanding TravisCI code:

1. Activate TravisCI tracking on your repo

2. You need to have .travis.yml file in the root of your repo so that TravisCI knows what it needs to do.

3. Below .travis.yml activates a terraform plan and automates the deployment:

```yaml
#-------.travis.yml-------

# Distribution that TravisCI should use in order to perform builds, tests and deployments

dist: xenial

# Most of the distributions comes with certain packages as addons and you don't have to go through the process of installing them. Refer documentation to verify if the addon exists.

addons:
  snaps:
    - name: hugo
    - name: aws-cli
      classic: true
      channel: latest/edge

branches:
  only:
    - master

# Installing terraform and setting it in path env

before_install:
  - curl -sLo /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.12.6/terraform_0.12.6_linux_amd64.zip
  - unzip /tmp/terraform.zip -d /tmp
  - mkdir -p ~/bin
  - mkdir -p ~/.aws
  - mv /tmp/terraform ~/bin
  - export PATH="~/bin:$PATH"

# Execute the aws_envs.sh script to set AWS keys

before_script:
  - ./terraform/aws_envs.sh

# build hugo website
script:
  - terraform --version
  - hugo

# run script for terraform plan and apply

deploy:
  - provider: script
    skip_cleanup: true
    script: bash deploy.sh

# Need to invalidate cloudfront distribution cache for changes to propogate immediately

after_deploy:
  - aws cloudfront create-invalidation --distribution-id $CLOUDFRONT_DIST --paths "/*"

```

```bash
#-------terraform/aws_envs.sh--------
#!/usr/bin/env bash

cat > ~/.aws/credentials << EOL
[default]
aws_access_key_id = ${AWS_ACCESS_KEY}
aws_secret_access_key = ${AWS_SECRET_KEY}
region = ${AWS_DEFAULT_REGION}
EOL

export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_KEY
export AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION
```

```bash
#---- deploy.sh ---------
#!/usr/bin/env bash

cd terraform
terraform init
terraform taint null_resource.upload_files_s3
terraform plan
terraform apply -auto-approve
```

That's it.. next time you perform git push on your master branch, TravisCI will be instigated to perform automatic build and deployment.

Now.. Enjoy visiting your website! <i class="far fa-grin-hearts"></i>

### Caveats and possible enhancements

Below are some of my upcoming plans to better this code:

- If you notice, we are using 'null_resource' with 'local-exec' provisioner to upload the hugo's public folder to AWS S3.
The problem with this is that Terraform does not notice any changes to the content of this folder. 
Hence, to deploy the content changes, the workaround I found was to taint this resource so that it gets applied in next Terraform plan.
This is automated when using TravisCI.
- The AWS cloudfront distribution invalidation needs to be performed manually after content changes.
As per my research, cloudfront holds the cache (by default) for 24 hours and hence it becomes mandatory to clear this when you make significant content changes.
Again, we have achieved this using TravisCI.

However, both these loopholes do have an official way in Terraform, which involves using AWS Lambda!

Hope you enjoyed this blog! <i class="far fa-smile"></i>

