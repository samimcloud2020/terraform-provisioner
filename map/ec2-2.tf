variable "account_name" {
   type = "map"
  default = {
      "account1" = "devops1"
      "account2" = "devops2"
      "account3" = "devops3"
}
}
resource "aws_iam_user" "iamuser" {
  for_each = var.account_name
  name = "${each.value}-iam"
}
