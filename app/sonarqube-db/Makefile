# Makefile for running Terraform commands

# Variables
TF_DIR := .

# Targets
init:
	cd $(TF_DIR) && terraform init

plan:
	cd $(TF_DIR) && terraform plan

validate:
	cd $(TF_DIR) && terraform validate

apply:
	cd $(TF_DIR) && terraform apply

.PHONY: init plan validate apply