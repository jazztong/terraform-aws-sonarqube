resource "aws_eip" "this" {
  instance = aws_instance.this.id
}

resource "aws_instance" "this" {
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  iam_instance_profile   = aws_iam_instance_profile.this.name
  user_data              = data.template_file.user_data.rendered
  vpc_security_group_ids = [aws_security_group.this.id]
  subnet_id              = var.subnet_id

  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
  }

  monitoring    = true
  ebs_optimized = true

  tags = merge(
    {
      Name = "${local.prefix}-instance"
    },
    var.tags
  )

  lifecycle {
    // Side effort of external attach public ip will change this state
    ignore_changes = [associate_public_ip_address]
  }
}
