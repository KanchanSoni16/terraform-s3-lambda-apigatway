/*resource "null_resource" "graph_creation" {
  depends_on = [
    aws_cloudfront_distribution.api_gateway_cf
  ]
  provisioner "local-exec" {
    command = "./graph.sh"
      }
  }*/
resource "null_resource" "git_clone" {
  depends_on = [
    aws_cloudfront_distribution.api_gateway_cf
  ]
    provisioner "local-exec" {
    command = "./git.sh"
    }
}

