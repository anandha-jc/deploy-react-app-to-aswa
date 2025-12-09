# Terraform Commands Quick Reference

## Initialize Terraform
terraform init

## Validate Configuration
terraform validate

## Format Code
terraform fmt -recursive

## Plan Changes (Preview)
terraform plan

## Apply Changes
terraform apply

## Apply Without Confirmation
terraform apply -auto-approve

## Destroy Infrastructure
terraform destroy

## Show Current State
terraform show

## List Resources
terraform state list

## Get Output Values
terraform output

## Get Specific Output
terraform output static_web_app_default_hostname

## Upgrade Provider Versions
terraform init -upgrade
