variable "region" {
  type = "map"  
  default = { 
  "oregon" = "us-west-2"
  "virginia" = "us-east-1"
  "ohio" = "us-east-2"
  "california" = "us-west-1"
  "canada" = "ca-central-1"
  "frankfurt" =	"eu-central-1"
  "ireland" = "eu-west-1"
  }
}

variable "amis" {
  type = "map"
  default = {
      "us-west-1" = "ami-08fd8ae3806f09a08"
      "us-west-2" = "ami-06f2f779464715dc5"
      "us-east-1" = "ami-07d0cf3af28718ef8"
      "us-east-2" = "ami-05c1fa8df71875112"
      "ca-central-1" = "ami-0d0eaed20348a3389"
      "eu-west-1" = "ami-06358f49b5839867c"
      "eu-central-1" = "ami-0ac05733838eabc06"
  }
}




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
  region     = "frankfurt"
}

# Create a AWS instance template for CI server, using module
module "jenkins" {
  source      = "./Jenkins"
  region     = var.region
  amis = var.amis[var.region]
}

# Create a AWS instance template for application server, using module
module "carts" {
  source      = "./Appserver"
  region     = var.region
  amis = var.amis[var.region]
}

# Create a AWS instance template for database server, using module
module "database" {
  source      = "./Database"
  region     = var.region
  amis = var.amis[var.region]
}


# Launch instances from templates
resource "aws_launch_configuration" "Jenkins" {
  name          = "Jenkins"
  image_id      = "aws_launch_template.Jenkins"
  instance_type = "t2.micro"
  # provisioner "local-exec" {
    # command = "echo ${aws_instance.jenkins.public_ip} > App_Server_Pub_ip_address.txt"
# }
}

resource "aws_launch_configuration" "Carts" {
  name          = "Carts"
  image_id      = "aws_launch_template.Carts"
  instance_type = "t2.micro"
}

resource "aws_launch_configuration" "Database" {
  name          = "Database"
  image_id      = "aws_launch_template.Database"
  instance_type = "t2.micro"
}

