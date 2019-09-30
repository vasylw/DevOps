# Cloud provider setting
provider "aws" {
  profile    = "default"
  region     = var.region
}

# Create a AWS instance template for CI server, using module in *.tf file
module "jenkins" {
  source      = "Jenkins.tf"
  num_servers = "1"
  instances = module.jenkins.instance_ids
}

# Create a AWS instance template for application server, using module in *.tf file
module "carts" {
  source      = "Appserver.tf"
  num_servers = "1"
  instances = module.carts.instance_ids
}

# Create a AWS instance template for database server, using module in *.tf file
module "database" {
  source      = "Database.tf"
  num_servers = "1"
  instances = module.database.instance_ids
}


# Launch instances from templates
launch_template = {
      id      = "${aws_launch_template.Jenkins.id}"
      version = "$$Latest"
      id      = "${aws_launch_template.Database.id}"
      version = "$$Latest"
      id      = "${aws_launch_template.Carts.id}"
      version = "$$Latest"
}



provisioner "local-exec" {
    command = "echo ${aws_instance.Jenkins.public_ip} > CI_Server_Pub_ip_address.txt"
}

provisioner "local-exec" {
    command = "echo ${aws_instance.Carts.public_ip} > App_Server_Pub_ip_address.txt"
}


resource "aws_eip" "ip" {
    vpc = true
    instance = aws_instance.example.id
}