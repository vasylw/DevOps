provisioner "local-exec" {
    command = "echo ${aws_instance.Carts.public_ip} > App_Server_Pub_ip_address.txt"
}

provisioner  "local-exec" {
    command = "echo ${aws_instance.Jenkins.public_ip} > CI_Server_Pub_ip_address.txt"
}