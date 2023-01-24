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
        default = "homework1"
}

variable "instance_type" {
        default = "t3.micro"
}

variable "subnet_id" {
        description = "The VPC subnet the instance(s) will be created in"
        default = "subnet-079b617034f004c86"
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
        default = "us-east-1a"
}
