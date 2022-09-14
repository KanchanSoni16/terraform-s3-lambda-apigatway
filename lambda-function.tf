#This Configuration file is creating for LAMBDA Function 

#Converting Source Code in Zip file
data "archive_file" "lambda_api_function" {
  type        = "zip"
  source_file = var.source_file
  output_path = var.lambda_zip_location
}

#Creating Lambda Function 

resource "aws_lambda_function" "AWS_S3_API_Lambda_Function" {
  filename         = var.lambda_zip_location
  function_name    = var.function_name
  role             = aws_iam_role.api_role.arn
  handler          = "lambda_api_function.lambda_handler"
  source_code_hash = filebase64sha256(var.lambda_zip_location)
  runtime          = var.runtime
  environment {
    variables = {
    CreatedBy = "Terraform" }
  }
}

# Adding S3 bucket as trigger to my lambda and giving the permissions

resource "aws_s3_bucket_notification" "aws-lambda-trigger" {
  bucket = aws_s3_bucket.api_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.AWS_S3_API_Lambda_Function.arn
    events              = ["s3:ObjectCreated:*", "s3:ObjectRemoved:*", "s3:ObjectRestore:*"]
  }

  depends_on = [
    #aws_s3_bucket.api_bucket
    aws_lambda_permission.allow_bucket
  ]
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.AWS_S3_API_Lambda_Function.arn
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${aws_s3_bucket.api_bucket.id}"
}