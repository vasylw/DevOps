provider "aws" {
  profile    = "default"
  region     = var.region
}


resource "aws_instance" "jenkins" {
  
  instances = module.jenkins.instance_ids
}

resource "aws_instance" "carts" {
  
  instances = module.carts.instance_ids
}

resource "aws_instance" "database" {
  
  instances = module.Database.instance_ids
}


provisioner "local-exec" {
    command = "echo ${aws_instance.jenkins.public_ip} > CI_Server_ip_address.txt"
    command = "echo ${aws_instance.carts.public_ip} > App_server_ip_address.txt"
    command = "echo ${aws_instance.database.public_ip} > Database_server_ip_address.txt"
  }
}

resource "aws_eip" "ip" {
    vpc = true
    instance = aws_instance.example.id
}