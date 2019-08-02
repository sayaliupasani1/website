#------root/main.tf---------

provider "aws" {
	region     = "${var.region}"
	access_key = "${var.aws_access_key}"
	secret_key = "${var.aws_secret_key}"
}

resource "aws_s3_bucket" "website_s3" {
	bucket = "www.${var.domain_name}"
	acl    = "public-read"

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
 	  index_document ="index.html"
 	  error_document ="404.html"
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
	  when    = "destroy"
	  command = "aws s3 rm s3://${aws_s3_bucket.website_s3.id} --recursive"
	}
}

/* Using an existing ACM certificate
data resource is to check its existence via terraform */

data "aws_acm_certificate" "site_cert" {
	domain = "${var.domain_name}"
	statuses = ["ISSUED"]
}


 # Configuring CloudFront distribution

resource "aws_cloudfront_distribution" "site_distribution" {
 	origin {

 	  custom_origin_config {
 	    http_port              = "80"
 	    https_port             = "443"
 	    origin_protocol_policy ="http-only"
 	    origin_ssl_protocols   =["TLSv1", "TLSv1.1", "TLSv1.2"]
 	  }

 	  domain_name = "${aws_s3_bucket.website_s3.website_endpoint}"
 	  origin_id = "${var.domain_name}"
 	}
 	enabled             = true
 	retain_on_delete    = true
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

/* Using an existing AWS hosted zone (if you register your domain with Amazon, this hosted zone will be created automatically. You can delete the entries so that the records are terraform controlled.) */

data "aws_route53_zone" "hosted-zone" {
	name = "${var.domain_name}"
}

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