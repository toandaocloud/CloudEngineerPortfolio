output "instance_public_ip" {
   description = " the public ip address of the ec2 instance"
    value = aws_instance.my_first_server_tf.public_ip
}
output "instance_id" {
   description = " the id of the ec2 instance"
   value = aws_instance.my_first_server_tf.id
}
output "ec2_instance_type" {
 description = " the instance type of the ec2 instance"
  value = aws_instance.my_first_server_tf.instance_type
}
