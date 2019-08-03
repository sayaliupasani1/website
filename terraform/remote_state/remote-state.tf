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