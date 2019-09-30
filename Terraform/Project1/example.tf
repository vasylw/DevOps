# Cloud provider setting
# Available regions
# "oregon" = "us-west-2"
#  "virginia" = "us-east-1"
#  "ohio" = "us-east-2"
#  "california" = "us-west-1"
#  "canada" = "ca-central-1"
#  "frankfurt" =	"eu-central-1"
#  "ireland" = "eu-west-1"

provider "aws" {
  profile    = "default"
  region     = "${var.region["frankfurt"]}"
}

# Create a AWS instance template for CI server, using module in *.tf file
module "jenkins" {
  source      = "./Jenkins"
}

# Create a AWS instance template for application server, using module in *.tf file
module "carts" {
  source      = "./Appserver"
}

# Create a AWS instance template for database server, using module in *.tf file
module "database" {
  source      = "./Database"
}


# Launch instances from templates
resource "aws_launch_configuration" "Jenkins" {
  name          = "Jenkins"
  image_id      = "${aws_launch_template.Jenkins}"
  provisioner  "local-exec" {
    command = "echo ${aws_instance.Jenkins.public_ip} > CI_Server_Pub_ip_address.txt"
  }
}

resource "aws_launch_configuration" "Carts" {
  name          = "Carts"
  image_id      = "${aws_launch_template.Carts}"
}

resource "aws_launch_configuration" "Database" {
  name          = "Database"
  image_id      = "${aws_launch_template.Database}"
  provisioner "local-exec" {
    command = "echo ${aws_instance.Carts.public_ip} > App_Server_Pub_ip_address.txt"
  }
}
