# Cloud provider setting
provider "aws" {
  profile    = "default"
  region     = var.region[var.uf_region]
}

# Create a AWS instance template for CI server, using module
module "jenkins" {
  source      = "./Jenkins"
  availability_zone     = var.region[var.uf_region]
  image_id = var.amis[var.region[var.uf_region]]
  instance_name = "jenkins"
}

# Create a AWS instance template for application server, using module
module "carts" {
  source      = "./Appserver"
  availability_zone     = var.region[var.uf_region]
  image_id = var.amis[var.region[var.uf_region]]
  instance_name = "carts"
}

# Create a AWS instance template for database server, using module
module "database" {
  source      = "./Database"
  availability_zone     = var.region[var.uf_region]
  image_id = var.amis[var.region[var.uf_region]]
  instance_name = "database"
}




# Launch instances from templates

resource "aws_launch_configuration" "jenkins" {
  name          = "jenkins"
       = "jenkins"
  instance_type = "t2.micro"
 # provisioner "local-exec" {
    # command = "echo ${aws_instance.jenkins.public_ip} > App_Server_Pub_ip_address.txt"
  # }
}

resource "aws_launch_configuration" "carts" {
  name          = "carts"
  = "carts"
  instance_type = "t2.micro"
  # provisioner "local-exec" {
    # command = "echo ${aws_instance.carts.public_ip} > App_Server_Pub_ip_address.txt"
  # }
}

resource "aws_launch_configuration" "database" {
  name          = "database"
    = "database"
  instance_type = "t2.micro"
}

