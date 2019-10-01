variable "region" {
    type = "map"
}

variable "amis" {
  type = "map"
}

resource "aws_launch_template" "jenkins" {
  name = "jenkins"
    
    block_device_mappings {
            device_name = "/dev/sda1"
             ebs {
                    encrypted = false
                    delete_on_termination = true
                    volumeSize = 15
                }
    }
        
    network_interfaces {
            associate_public_ip_address = true
            delete_on_termination = true
            description = "Primary network interface"
            groups = "sg-083c31775b1fa65f0"
            interface_type = "interface"
             private_ip_addresses { primary = true }
            subnet_id = "subnet-214a766a"
    }

    image_id = var.amis[var.region]

    key_name = "EC2_Linux_CI_Server"
        monitoring  { enabled = false }
        placement { availability_zone = var.region }

    disable_api_termination = true

    instance_initiated_shutdown_behavior = "stop"

    tag_specifications {
        resource_type = "instance"
            tags {
                key = "name"
                value = "jenkins"
                }
    }

    credit_specification { cpu_credits = "standard" }
    
    cpu_options {
            core_count = 1
            threads_per_core = 1
    }
    
    capacity_reservation_specification { capacity_reservation_preference = "open" }
    
    hibernation_options { configured = false }
}