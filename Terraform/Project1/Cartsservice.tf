# Cloud provider setting
provider "aws" {
  profile    = "default"
  region     = var.uf_region
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
  region     = var.region[var.uf_region]
  amis = var.amis[var.region[var.uf_region]]
}

# Create a AWS instance template for database server, using module
module "database" {
  source      = "./Database"
  region     = var.region[var.uf_region]
  amis = var.amis[var.region[var.uf_region]]
}


# Launch instances from templates
resource "aws_launch_configuration" "jenkins" {
  name          = "Jenkins"
  image_id      = "aws_launch_template.jenkins"
  instance_type = "t2.micro"
  # provisioner "local-exec" {
    # command = "echo ${aws_instance.jenkins.public_ip} > App_Server_Pub_ip_address.txt"
# }
}

resource "aws_launch_configuration" "carts" {
  name          = "carts"
  image_id      = "aws_launch_template.carts"
  instance_type = "t2.micro"
}

resource "aws_launch_configuration" "database" {
  name          = "database"
  image_id      = "aws_launch_template.database"
  instance_type = "t2.micro"
}

