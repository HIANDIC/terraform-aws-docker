variable "instance_type" {
    type = string
    default = "t2.micro"  
    description = "you can choose your own insance type or you can default t2.micro"
}

variable "key_name" {
    type = string  
    description = "enter your key name"
}


variable "number_of_intance" {
    type = number
    default = 1  
}

variable "tag" {
    type = string
    default = "Docker-Instance"  
}

variable "server_name" {
    type = string
    default = "docker-instance"  
}

variable "docker_instance_ports" {
    type = list(number)
    default = [22, 80, 8080]  
    description = "docker-instance-sec-gr-inbound-rules"
}





