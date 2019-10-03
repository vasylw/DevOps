
resource "aws_launch_template"  "instance" {
    name = "${var.instance_name}"
    block_device_mappings {
            device_name = "/dev/sda1"
             ebs {
                    encrypted = false
                    delete_on_termination = true
                    volume_size = 15
                }
    }
        
    network_interfaces {
      associate_public_ip_address = true
      delete_on_termination = true
      description = "Primary network interface"
      groups = ["carts_sg"]
      private_ip_addresses {
        primary = "true"
        private_ip_address = "172.31.50.102"
      }
    }
    
    image_id = var.image_id
    
    instance_type = var.instance_type

    key_name = "EC2_Linux_CI_Server"

    user_data = "TUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiBtdWx0aXBhcnQvbWl4ZWQ7IGJvdW5kYXJ5PSI9PU1ZQk9VTkRBUlk9PSIKLS09PU1ZQk9VTkRBUlk9PQpDb250ZW50LVR5cGU6IHRleHQvY2xvdWQtY29uZmlnOyBjaGFyc2V0PSJ1cy1hc2NpaSIKCnJ1bmNtZDoKLSBzdWRvIGFwdCAteSB1cGRhdGUKLSBzdWRvIGFwdCAteSBpbnN0YWxsIG9wZW5qZGstOC1qZGsKLSBzdWRvIHVmdyBhbGxvdyA4MDgxCgotLT09TVlCT1VOREFSWT09LS0="

    monitoring  { enabled = false }

    placement { availability_zone = var.availability_zone }

    disable_api_termination = true

    instance_initiated_shutdown_behavior = "stop"
   
    provisioner "file" {
    source      = "JavaInstall.sh"
    destination = "/tmp/JavaInstall.sh"
    }

    provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/JavaInstall.sh",
      "/tmp/JavaInstall.sh args",
    ]
    }
    
}