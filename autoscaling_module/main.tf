resource "aws_appautoscaling_target" "dynamodb_read_target" {
  count              = "${var.autoscaling_enabled ? 1 : 0}"
  min_capacity       = "${var.capacity["min_read"]}"
  max_capacity       = "${var.capacity["max_read"]}"
  resource_id        = "${var.type}/${var.resource_id}"
  role_arn           = "${data.aws_iam_role.dynamodb_autoscaling_role.arn}"
  scalable_dimension = "dynamodb:${var.type}:ReadCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "dynamodb_read_policy" {
  count              = "${var.autoscaling_enabled ? 1 : 0}"
  name               = "DynamoDBReadCapacityUtilization:${aws_appautoscaling_target.dynamodb_read_target.resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = "${aws_appautoscaling_target.dynamodb_read_target.resource_id}"
  scalable_dimension = "${aws_appautoscaling_target.dynamodb_read_target.scalable_dimension}"
  service_namespace  = "${aws_appautoscaling_target.dynamodb_read_target.service_namespace}"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBReadCapacityUtilization"
    }

    target_value = "${var.target_value}"
  }
}

resource "aws_appautoscaling_target" "dynamodb_write_target" {
  count              = "${var.autoscaling_enabled ? 1 : 0}"
  min_capacity       = "${var.capacity["min_write"]}"
  max_capacity       = "${var.capacity["max_write"]}"
  resource_id        = "${var.type}/${var.resource_id}"
  role_arn           = "${data.aws_iam_role.dynamodb_autoscaling_role.arn}"
  scalable_dimension = "dynamodb:${var.type}:WriteCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "dynamodb_write_policy" {
  count              = "${var.autoscaling_enabled ? 1 : 0}"
  name               = "DynamoDBReadCapacityUtilization:${aws_appautoscaling_target.dynamodb_write_target.resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = "${aws_appautoscaling_target.dynamodb_write_target.resource_id}"
  scalable_dimension = "${aws_appautoscaling_target.dynamodb_write_target.scalable_dimension}"
  service_namespace  = "${aws_appautoscaling_target.dynamodb_write_target.service_namespace}"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBWriteCapacityUtilization"
    }

    target_value = "${var.target_value}"
  }
}

data "aws_iam_role" "dynamodb_autoscaling_role" {
  name = "AWSServiceRoleForApplicationAutoScaling_DynamoDBTable"
}
