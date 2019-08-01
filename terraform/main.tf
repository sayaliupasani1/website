#------root/main.tf---------

provider "aws" {
	region = "${var.region}"
	access_key = "${var.aws_access_key}"
	secret_key = "${var.aws_secret_key}"
}

resource "aws_s3_bucket" "website_s3" {
	bucket = "${var.domain_name}"
	acl = "public-read"

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
 	
 	website {
 	  index_document="index.html"
 	  error_document="404.html"
 	}

	tags = {
	  Name = "Website_bucket"
	}
}

resource "null_resource" "upload_files_s3" {
	provisioner "local-exec" {
	  command = "aws s3 sync ${path.cwd}/../public s3://${aws_s3_bucket.website_s3.id}"
	}
}

resource "null_resource" "delete_files_s3" {
	provisioner "local-exec" {
	  when = "destroy"
	  command = "aws s3 rm s3://${aws_s3_bucket.website_s3.id} --recursive"
	}
}

resource "aws_s3_bucket_object" "config" {
	bucket = "${aws_s3_bucket.website_s3.id}"
	key = "config.toml"
	source = "${path.cwd}/../config.toml"
}