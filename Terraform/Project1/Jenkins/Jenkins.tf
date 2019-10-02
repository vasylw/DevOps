
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
    }
    
    image_id = var.image_id
    
    instance_type = var.instance_type

    key_name = "EC2_Linux_CI_Server"

    monitoring  { enabled = false }

    placement { availability_zone = var.availability_zone }

    disable_api_termination = true

    instance_initiated_shutdown_behavior = "stop"
   
    provisioner "file" {
    source      = "JavaMavenJenkinsInstall.sh"
    destination = "/tmp/JavaMavenJenkinsInstall.sh"
    }

    provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/JavaMavenJenkinsInstall.sh",
      "/tmp/JavaMavenJenkinsInstall.sh args",
    ]
    }


}
