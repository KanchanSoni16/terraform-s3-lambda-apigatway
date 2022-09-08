#This Configuration file is creating terraform state backend 

# AWS S3 Bucket Creation
resource "aws_s3_bucket" "statefile-bucket" {
  bucket = var.state_bucket_name
  tags = {
    Name        = "${var.myregion}-${var.state_bucket_name}"
    Environment = "${var.environment}"
  }
}
#Assigning ACL permission for AWS S3 Bucket 
resource "aws_s3_bucket_acl" "state_bucket_acl" {
  bucket = aws_s3_bucket.statefile-bucket.id
  acl    = "private"
}

# AWS Dynamodb table Creation

resource "aws_dynamodb_table" "state-locking" {
  name           = "state-locking"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}