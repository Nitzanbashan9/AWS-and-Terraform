resource "aws_instance" "nginx_server1" {
  root_block_device {
    volume_size           = "10"
    volume_type           = "gp2"
    encrypted             = false
    delete_on_termination = true
  }
  availability_zone = "${var.az}"
  ami           = "${var.ami_id}"
  instance_type = "t3.micro"

  tags = {
    Name = "ngnix-server-1"
    Owner = "Nitzan"
    Purpose = "whiskey"
  }
  user_data = <<EOF
    #!/bin/bash
    sudo amazon-linux-extras install nginx1
    sudo service nginx start
    sudo rm /usr/share/nginx/html/index.html
    sudo echo "<html><head><title>Grandpa's Whiskey</title></head><body>Welcome to Grandpa's Whiskey</body></html>" > /usr/share/nginx/html/index.html
  EOF
}


resource "aws_instance" "nginx_server2" {
    root_block_device {
    volume_size           = "10"
    volume_type           = "gp2"
    encrypted             = false
    delete_on_termination = true
  }
  availability_zone = "${var.az}"
  ami           = "${var.ami_id}"
  instance_type = "t3.micro"

  tags = {
    Name = "ngnix-server-2"
    Owner = "Nitzan"
    Purpose = "whiskey"
  }
  user_data = <<EOF
    #!/bin/bash
    sudo amazon-linux-extras install nginx1
    sudo service nginx start
    sudo rm /usr/share/nginx/html/index.html
    sudo echo "<html><head><title>Grandpa's Whiskey</title></head><body>Welcome to Grandpa's Whiskey</body></html>" > /usr/share/nginx/html/index.html
  EOF
}