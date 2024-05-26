locals {
  prefix = "${var.name}-${var.env}"
  role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM",
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",
  ]
}
