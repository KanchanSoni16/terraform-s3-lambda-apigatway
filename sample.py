# python code kept for back up purpose

import json
import urllib.parse
import boto3

print('Loading function')

s3 = boto3.client('s3')


def lambda_handler(event, context):
    #print("Received event: " + json.dumps(event, indent=2))

    # Get the object from the event and show its content type
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')
    #location = boto3.client('s3').get_bucket_location(Bucket=bucket)['LocationConstraint']
   # if location == None: location = 'us-east-1'
    url = "https://%s.s3.amazonaws.com/%s" % (bucket, key)
  
    try:
        #response = s3.get_object(Bucket=bucket, Key=key)
        response = url
        #print (location)
        #print("CONTENT TYPE: " + response['url'])
        return response
        
    except Exception as e:
        print(e)
        print('Error getting object {} from bucket {}. Make sure they exist and your bucket is in the same region as this function.'.format(key, bucket))
        raise e



  import json
import urllib.parse
import boto3

print('Loading function')

s3 = boto3.client('s3')


def lambda_handler(event, context):
    #print("Received event: " + json.dumps(event, indent=2))

    # Get the object from the event and show its content type
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')
    #location = boto3.client('s3').get_bucket_location(Bucket=bucket)['LocationConstraint']
   # if location == None: location = 'us-east-1'
    url = "https://%s.s3.amazonaws.com/%s" % (bucket, key)
  
    try:
        #response = s3.get_object(Bucket=bucket, Key=key)
        response = url
        #print (location)
        #print("CONTENT TYPE: " + response['url'])
        return response
        
    except Exception as e:
        print(e)
        print('Error getting object {} from bucket {}. Make sure they exist and your bucket is in the same region as this function.'.format(key, bucket))
        raise e
        


        '''import json
import urllib.parse
import boto3

print('Loading function')

s3 = boto3.client('s3')

def lambda_handler(event, context):
    #print("Received event: " + json.dumps(event, indent=2))

    # Get the object from the event and show its content type
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')

    url = "https://%s.s3.amazonaws.com/%s" % (bucket, key)

    try:
        #response = s3.get_object(Bucket=bucket, Key=key)
        #print("CONTENT TYPE: " + response['ContentType'])
        #return response['ContentType']
        return url
    except Exception as e:
        print(e)
        print('Error getting object {} from bucket {}. Make sure they exist and your bucket is in the same region as this function.'.format(key, bucket))
        raise e'''
'''
import json
import boto3

s3 = boto3.resource('s3')

def lambda_handler(event, context):

 bucketlist = []

 for bucket in s3.buckets.all():
  bucketlist.append(bucket.name)

 return {
  "statusCode": 200,
  "body": bucketlist
 }'''

        
#object code
import json
import boto3
import urllib.parse

s3_client = boto3.client("s3")
S3_BUCKET = 'us-east-1-lambdabucketapi'

def lambda_handler(event, context):
  object_key = "sample.txt"
  file_content = s3_client.get_object(
      Bucket=S3_BUCKET, Key=object_key)["Body"].read()
  print(file_content)
  
  return {
    "statusCode": 200,
    "body": file_content
  }

      
        


      ####  other important terraform codes###

        # Additng permission for lambda function to trigger API Gateway

/*resource "aws_api_gateway_rest_api" "rest_api" {
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "rest_api"
      version = "1.0"
    }
    paths = {
      "/" = {
        get = {
          x-amazon-apigateway-integration = {
            httpMethod           = "GET"
            authorization = var.method_authorization
            payloadFormatVersion = "1.0"
            type                 = "AWS"
            uri                  = aws_lambda_function.AWS_S3_API_Lambda_Function.invoke_arn
            credentials           = aws_iam_role.apigatway_role.arn
          }
        }
      }
    }
  })

  name = var.api_name
  description = var.api_description
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}*/


# Creating ANY Method unders Resources

#resource "aws_api_gateway_method" "rest_api_method" {
#  authorization = "NONE"
#  http_method   = "ANY"
#  resource_id   = aws_api_gateway_resource.rest_api_resources.id
#  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
#}


# Integrating API Gateway with Lambda Function for ANY http method

#resource "aws_api_gateway_integration" "rest_api_integration" {
#  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
#  resource_id             = aws_api_gateway_resource.rest_api_resources.id
#  http_method             = aws_api_gateway_method.rest_api_method.http_method
#  integration_http_method = "GET"
#  type                    = "AWS_PROXY"
#  uri                     = aws_lambda_function.AWS_S3_API_Lambda_Functiom.invoke_arn
#}

