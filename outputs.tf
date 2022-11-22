output "instance_public_ip" {
    # user can create more than one instance. Because of that we are using * to represent 
    # unknown number of instances
    value = aws_instance.tf_my_ec2.*.public_ip
    description = "public ip of instance or instances"
}

output "sec_gr_id" {
    value = aws_security_group.tf-sec-gr.id
    description = "security group id"
}

output "instance_id" {
    # user can create more than one instance. Because of that we are using * to represent 
    # unknown number of instances
    value = aws_instance.tf_my_ec2.*.id
    description = "instance id of instance or instances"
}