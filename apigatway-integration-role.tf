
#This Configuration file is creating IAM Role for API Gatway

#Role Creating for Api Gateway access to Lambda Function
resource "aws_iam_role" "apigatway_role" {
  name = var.api_role_name

  assume_role_policy = file(var.api_assume_role_policy)
}


#Policy Creating for API Gateway Role 

resource "aws_iam_role_policy" "apigatway_policy" {
  name = var.api_policy_name
  role = aws_iam_role.apigatway_role.id

  policy = file(var.api_policy)

}