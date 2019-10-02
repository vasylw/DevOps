# Cloud provider setting
provider "aws" {
  profile    = "default"
  region     = var.region[var.uf_region]
}

# Create a AWS instance template for CI server, using module
module "jenkins" {
  source      = "./Jenkins"
  availability_zone     = var.azone[var.uf_azone]
  image_id = var.amis[var.region[var.uf_region]]
  instance_name = "jenkins"
  instance_type = var.instance_type
}

# Create a AWS instance template for Application server, using module
module "carts" {
  source      = "./Appserver"
  availability_zone     = var.azone[var.uf_azone]
  image_id = var.amis[var.region[var.uf_region]]
  instance_name = "carts"
  instance_type = var.instance_type
}

# Create a AWS instance template for database server, using module
module "database" {
  source      = "./Database"
  availability_zone     = var.azone[var.uf_azone]
  image_id = var.amis[var.region[var.uf_region]]
  instance_name = "database"
  instance_type = var.instance_type
}




# Launch instances from templates
resource "aws_autoscaling_group" "ag_jenkins" {
  availability_zones     = [var.azone[var.uf_azone]]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1
  launch_template {
    id      = "${module.jenkins.launch_template_ids}"
  }
  tag {
    key                 = "instance_name"
    value               = "jenkins"
    propagate_at_launch = true
  }
}

# Launch instances from templates
resource "aws_autoscaling_group" "ag_carts" {
  availability_zones     = [var.azone[var.uf_azone]]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  launch_template {
    id      = "${module.carts.launch_template_ids}"
    }
  tag {
    key                 = "instance_name"
    value               = "carts"
    propagate_at_launch = true
  }
}

# Launch instances from templates
resource "aws_autoscaling_group" "ag_database" {
  availability_zones     = [var.azone[var.uf_azone]]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  launch_template {
    id      = "${module.database.launch_template_ids}"
    }
  tag {
    key                 = "instance_name"
    value               = "database"
    propagate_at_launch = true
  }
}








# resource "aws_launch_configuration" "jenkins" {
#  name          = "jenkins"
 # instance_type = "t2.micro"
 # launch_template = {
 #   id      = "${module.jenkins.launch_template_id}"
 # }
    # provisioner "local-exec" {
    # command = "echo ${aws_instance.jenkins.public_ip} > App_Server_Pub_ip_address.txt"
  # }
#}

# resource "aws_launch_configuration" "carts" {
 # name          = "carts"
 # instance_type = "t2.micro"
  # provisioner "local-exec" {
    # command = "echo ${aws_instance.carts.public_ip} > App_Server_Pub_ip_address.txt"
  # }
# }

# resource "aws_launch_configuration" "database" {
#  name          = "database"
#  instance_type = "t2.micro"
# }

