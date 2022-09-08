
#This Configuration file is creating IAM Role for LAMBDA Function 

#Role Creating for Lambda Function
resource "aws_iam_role" "api_role" {
  name = var.lambda_role_name

  assume_role_policy = file(var.assume_role_policy)
}

#Policy Creating for Lambda Role 

resource "aws_iam_role_policy" "api_policy" {
  name = var.lambda_policy_name
  role = aws_iam_role.api_role.id

  policy = file(var.policy)

}