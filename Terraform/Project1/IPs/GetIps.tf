
locals {
  public_ips                    = compact(coalescelist(aws_instance.this.*.public_ip, [""]))
  private_ips                   = compact(coalescelist(aws_instance.this.*.private_ip, [""]))
}


output "public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = local.public_ips
}


output "private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = local.private_ips
}


