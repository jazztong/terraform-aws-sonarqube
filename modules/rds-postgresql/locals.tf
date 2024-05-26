locals {
  resource_prefix = "${var.name}-${var.env}"
  parameter_path  = "/${var.name}/${var.env}"
}