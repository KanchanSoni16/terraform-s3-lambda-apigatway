#This Configuration file is creating API Gateway and its resources

# Creating API gateway

resource "aws_api_gateway_rest_api" "rest_api" {
  name        = var.api_name
  description = var.api_description
  endpoint_configuration {
    types = [var.endpoint_types]
  }
}

# Creating Resources for API Gateway
resource "aws_api_gateway_resource" "rest_api_resources" {
  parent_id   = aws_api_gateway_rest_api.rest_api.root_resource_id
  path_part   = var.path_part
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
}

resource "aws_api_gateway_method" "rest_api_method1" {
  authorization = var.method_authorization
  http_method   = var.http_method
  resource_id   = aws_api_gateway_resource.rest_api_resources.id
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
}


# Integrating API Gateway with Lambda Function for GET http method

resource "aws_api_gateway_integration" "rest_api_integration1" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.rest_api_resources.id
  http_method             = aws_api_gateway_method.rest_api_method1.http_method
  integration_http_method = var.integration_http_method
  type                    = var.integration_type
  credentials             = aws_iam_role.apigatway_role.arn
  uri                     = aws_lambda_function.AWS_S3_API_Lambda_Function.invoke_arn
}

# Creating Method response 
resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.rest_api_resources.id
  http_method = aws_api_gateway_method.rest_api_method1.http_method
  status_code = var.status_code
  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "rest_api_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.rest_api_resources.id
  http_method = aws_api_gateway_method.rest_api_method1.http_method
  status_code = aws_api_gateway_method_response.response_200.status_code

  # Transforms the backend JSON response to XML
  response_templates = {
    "application/xml" = <<EOF
#set($inputRoot = $input.path('$'))
    $inputRoot.body
EOF
  }

  depends_on = [
    aws_api_gateway_integration.rest_api_integration1
  ]
}

resource "aws_api_gateway_deployment" "apideploy" {
  depends_on = [
    aws_api_gateway_integration.rest_api_integration1
  ]
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  stage_name  = var.stage_name
}


# Additng permission for lambda function to trigger API Gateway

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.AWS_S3_API_Lambda_Function.arn
  principal     = var.apigw_principal

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${var.myregion}:${var.accountId}:${aws_api_gateway_rest_api.rest_api.id}/*/${aws_api_gateway_method.rest_api_method1.http_method}${aws_api_gateway_resource.rest_api_resources.path}"
}




