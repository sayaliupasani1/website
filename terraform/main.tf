#------root/main.tf---------

provider "aws" {
	region = "${var.region}"
	access_key = "${var.aws_access_key}"
	secret_key = "${var.aws_secret_key}"
}

resource "aws_s3_bucket" "website_s3" {
	bucket = "website903840284755"
	acl = "private"

	tags = {
	  Name = "Website_bucket"
	}
}

resource "aws_s3_bucket_object" "config" {
	bucket = "${aws_s3_bucket.website_s3.id}"
	key = "config.toml"
	source = "${path.cwd}/../config.toml"
}