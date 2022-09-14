#output "invoke_url" {
#value = "${aws_api_gateway_stage.rest_api_stage.invoke_url}/${aws_api_gateway_resource.rest_api_resources.path_part}"
#}

output "bucket" {
  value = aws_s3_bucket.api_bucket.id
}

output "lambda_arn" {
  value = aws_lambda_function.AWS_S3_API_Lambda_Function.arn
}

output "aws_api_gateway_parent_id" {
  value = aws_api_gateway_rest_api.rest_api.root_resource_id
}

output "aws_s3_bucket_object_id" {
  value = aws_s3_object.object.id
}

