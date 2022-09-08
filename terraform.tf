
# terraform backend creation
/*
terraform{
  backend "s3" {
    bucket = "statefile-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "state-locking"
  }
}
*/

