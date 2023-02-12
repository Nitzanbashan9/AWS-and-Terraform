variable "access_key" {
        description = "Access key to AWS console"
}
variable "secret_key" {
        description = "Secret key to AWS console"
}

variable "user_data" {
    description = "The runtime script of the EC2"
    default = ""
}
variable "instance_name" {
        description = "Name of the instance to be created"
        default = "homework2"
}

variable "instance_type" {
        default = "t3.micro"
}


variable "ami_id" {
        description = "The AMI to use"
        default = "ami-0b5eea76982371e91"
}

variable "number_of_instances" {
        description = "number of instances to be created"
        default = 2
}


variable "ami_key_pair_name" {
        default = "Nitzan"
}

variable "az" {
        default = ["us-east-1a", "us-east-1b"]
}

variable "public_cidr" {
        default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_cidr" {
        default = ["10.0.100.0/24", "10.0.200.0/24"]
}