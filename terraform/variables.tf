#-----root/variables.tf-----

#-----Define aws variables-----

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "region" {
	default = "us-east-1"
}

variable "domain_name" {
	default = "www.sayaliupasani.com"
}

