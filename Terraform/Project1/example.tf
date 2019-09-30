provider "aws" {
  profile    = "default"
  region     = var.region
}

module "jenkins" {
  source      = "Jenkins.tf"
  num_servers = "1"
  instances = module.jenkins.instance_ids
}

module "carts" {
  source      = "Appserver.tf"
  num_servers = "1"
  instances = module.carts.instance_ids
}

module "database" {
  source      = "Database.tf"
  num_servers = "1"
  instances = module.database.instance_ids
}


provisioner "local-exec" {
    command = "echo ${aws_instance.jenkins.public_ip} > CI_Server_ip_address.txt"
    command = "echo ${aws_instance.carts.public_ip} > App_server_ip_address.txt"
    command = "echo ${aws_instance.database.public_ip} > Database_server_ip_address.txt"
  }


resource "aws_eip" "ip" {
    vpc = true
    instance = aws_instance.example.id
}