#INSTANCES
resource "aws_instance" "nginx_server1" {
  root_block_device {
    volume_size           = "10"
    volume_type           = "gp2"
    encrypted             = false
    delete_on_termination = true
  }
  availability_zone = "${var.az[0]}"
  ami           = "${var.ami_id}"
  instance_type = "t3.micro"
  subnet_id   = aws_subnet.public_subnet[0].id


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
  availability_zone = "${var.az[1]}"
  ami           = "${var.ami_id}"
  instance_type = "t3.micro"
  subnet_id   = aws_subnet.public_subnet[1].id

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

#EBS

resource "aws_ebs_volume" "nginx1" {
  availability_zone = "${var.az[0]}"
  size              = 10
  type           = "gp2"
  encrypted             = true
  tags = {
    Name = "nginx1"
  }
}

resource "aws_ebs_volume" "nginx2" {
  availability_zone = "${var.az[1]}"
  size              = 10
  type           = "gp2"
  encrypted             = true
  tags = {
    Name = "nginx2"
  }
}

#ATTACHMENTS
resource "aws_volume_attachment" "nginx1" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.nginx1.id
  instance_id = aws_instance.nginx_server1.id
}

resource "aws_volume_attachment" "nginx2" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.nginx2.id
  instance_id = aws_instance.nginx_server2.id
}




####DBs

resource "aws_instance" "DB1" {
  root_block_device {
    volume_size           = "10"
    volume_type           = "gp2"
    encrypted             = false
    delete_on_termination = true
  }
  availability_zone = "${var.az[0]}"
  ami           = "${var.ami_id}"
  instance_type = "t3.micro"
  subnet_id   = aws_subnet.private_subnet[0].id


  tags = {
    Name = "DB1"
  }
}

resource "aws_instance" "DB2" {
  root_block_device {
    volume_size           = "10"
    volume_type           = "gp2"
    encrypted             = false
    delete_on_termination = true
  }
  availability_zone = "${var.az[1]}"
  ami           = "${var.ami_id}"
  instance_type = "t3.micro"
  subnet_id   = aws_subnet.private_subnet[1].id


  tags = {
    Name = "DB2"
  }  
}  