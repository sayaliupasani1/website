#------root/main.tf---------

provider "aws" {
	region = "us-east-1"
}

resource "aws_s3_bucket" "website_s3" {
	bucket = "website9038402847"
	acl = "public"

	tags = {
	  Name = "Website_bucket"
	}
}

resource "aws_s3_bucket_object" "config" {
	bucket = "${aws_s3_bucket.website_s3.id}"
	key = "config.toml"
	source = "${path.cwd}/../config.toml"
}