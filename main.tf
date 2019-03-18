resource "aws_dynamodb_table" "table" {
  "attribute" {
    name = "${var.key}"
    type = "S"
  }

  hash_key       = "${var.key}"
  name           = "${var.table_name}"
  read_capacity  = "${var.read_capacity}"
  write_capacity = "${var.write_capacity}"
}

module "table_autoscaling" {
  source              = "./autoscaling_module"
  resource_id         = "${aws_dynamodb_table.table.id}"
  type                = "table"
  capacity            = "${var.capacity}"
  target_value        = "${var.target_value}"
  autoscaling_enabled = "${var.autoscaling_enabled}"
}
