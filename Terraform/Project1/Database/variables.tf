variable "image_id" {
  type = "string"
}

variable "availability_zone" {
  type = "string"
}

variable "instance_name" {
  type = "string"
}

variable "instance_type" {
  type = "string"
}

output "launch_template_ids" {
  value = aws_launch_template.instance.id
}
