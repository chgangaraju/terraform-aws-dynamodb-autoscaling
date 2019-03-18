variable "type" {}
variable "resource_id" {}

variable "capacity" {
  type = "map"
}

variable "target_value" {
  default = 70
}

variable "autoscaling_enabled" {
  default = true
}
