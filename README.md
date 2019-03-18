#terraform-aws-dynamodb-autoscaling

Terraform module to create dynamodb table with autoscaling enabled

###Example

    provider "aws" {
      region = "us-east-1"
    }
    module "test_table" {
      source = "terraform-aws-dynamodb-autoscaling"
      key = "id"
      table_name = "test"
      autoscaling_enabled = true
    }