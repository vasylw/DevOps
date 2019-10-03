
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
            groups = ["jenkins_sg"]
            private_ip_addresses {
              primary = "true"
              private_ip_address = "172.31.50.101"
            }
    }
    
    image_id = var.image_id
    
    instance_type = var.instance_type

    key_name = "EC2_Linux_CI_Server"

    user_data = "TUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiBtdWx0aXBhcnQvbWl4ZWQ7IGJvdW5kYXJ5PSI9PU1ZQk9VTkRBUlk9PSIKLS09PU1ZQk9VTkRBUlk9PQpDb250ZW50LVR5cGU6IHRleHQvY2xvdWQtY29uZmlnOyBjaGFyc2V0PSJ1cy1hc2NpaSIKCgpydW5jbWQ6Ci0gc3VkbyBhcHQgLXkgdXBkYXRlCi0gc3VkbyBhcHQgLXkgaW5zdGFsbCBvcGVuamRrLTgtamRrCi0gc3VkbyBhcHQgLXkgdXBkYXRlCi0gc3VkbyBhcHQgLXkgaW5zdGFsbCBtYXZlbgotIHdnZXQgLXEgLU8gLSBodHRwczovL3BrZy5qZW5raW5zLmlvL2RlYmlhbi9qZW5raW5zLmlvLmtleSB8IHN1ZG8gYXB0LWtleSBhZGQgLQotIHN1ZG8gc2ggLWMgJ2VjaG8gZGViIGh0dHA6Ly9wa2cuamVua2lucy5pby9kZWJpYW4tc3RhYmxlIGJpbmFyeS8gPiAvZXRjL2FwdC9zb3VyY2VzLmxpc3QuZC9qZW5raW5zLmxpc3QnCi0gc3VkbyBhcHQgLXkgdXBkYXRlCi0gc3VkbyBhcHQgLXkgaW5zdGFsbCBqZW5raW5zCi0gc3VkbyB1ZncgYWxsb3cgODA4MAoKLS09PU1ZQk9VTkRBUlk9PS0t"
    
    monitoring  { enabled = false }

    placement { availability_zone = var.availability_zone }

    disable_api_termination = true

    instance_initiated_shutdown_behavior = "stop"
   
    

}
