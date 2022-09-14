#This Configuration file is creating AWS S3 Bucket 

# AWS S3 Bucket Creation
resource "aws_s3_bucket" "api_bucket" {
  bucket = "${var.myregion}-${var.bucket_name}"
  #acl    = "private"
  tags = {
    Name        = "${var.myregion}-${var.bucket_name}"
    Environment = "${var.environment}"
  }
}
#Assigning ACL permission for AWS S3 Bucket 
resource "aws_s3_bucket_acl" "api_acl" {
  bucket = aws_s3_bucket.api_bucket.id
  acl    = var.acl
  depends_on = [
    aws_s3_bucket.api_bucket
  ]
}


#Object uploading in S3 bucket

resource "aws_s3_object" "object" {
  bucket = "${var.myregion}-${var.bucket_name}"
  key    = var.object_key
  source = var.object_source
  #content_type  = "text/plain"
  acl = var.object_acl
  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5(var.object_source)
  depends_on = [
    aws_s3_bucket.api_bucket
  ]
}