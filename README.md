# terraform-aws-dynamodb-autoscaling

Terraform module to create dynamodb table with autoscaling enabled

#### Example 1

    provider "aws" {
      region = "us-east-1"
    }
     
    module "test_table" {
      source     = "chgangaraju/terraform-aws-dynamodb-autoscaling"
      version    = "1.0.1"
      key        = "id"
      table_name = "test"
    }
    
#### Example 2

    provider "aws" {
      region = "us-east-1"
    }
     
    variable "capacity" {
      type = "map"
    
      default = {
        min_read  = 100
        max_read  = 4000
        min_write = 100
        max_write = 4000
      }
    }
     
    module "test_table" {
      source         = "chgangaraju/terraform-aws-dynamodb-autoscaling"
      version        = "1.0.1"
      key            = "id"
      table_name     = "test"
      read_capacity  = 100
      write_capacity = 100
      capacity       = "${var.capacity}"
    }

