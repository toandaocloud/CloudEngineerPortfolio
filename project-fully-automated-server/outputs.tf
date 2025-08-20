output "website_url" {
  description = " the url of the deployed web server"
  value = "http://${var.domain_name}"
}
output "instance_public_ip"{
 description = " the public ip address of the ec2 instance"
  value = aws_instance.web_server.public_ip
}
