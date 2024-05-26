resource "aws_iam_instance_profile" "this" {
  name = "${local.prefix}-ec2-profile"
  role = aws_iam_role.this.name
}

resource "aws_iam_role_policy_attachment" "this" {
  count = length(local.role_policy_arns)

  role       = aws_iam_role.this.name
  policy_arn = element(local.role_policy_arns, count.index)
}

resource "aws_iam_role" "this" {
  name = "${local.prefix}-ec2-role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow"
        }
    ]
}
EOF
}
