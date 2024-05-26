resource "aws_cloudwatch_log_group" "this" {
  name              = "/ec2/${local.prefix}"
  retention_in_days = 7

  tags = merge(
    {
      Name = "${local.prefix}-log-group"
    },
    var.tags
  )
}

resource "aws_cloudwatch_log_stream" "this" {
  name           = "${local.prefix}-log-stream"
  log_group_name = aws_cloudwatch_log_group.this.name
}
