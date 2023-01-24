resource "aws_ebs_volume" "nginx1" {
  availability_zone = "${var.az}"
  size              = 10
  type           = "gp2"
  encrypted             = true
  tags = {
    Name = "nginx1"
  }
}


resource "aws_ebs_volume" "nginx2" {
  availability_zone = "${var.az}"
  size              = 10
  type           = "gp2"
  encrypted             = true
  tags = {
    Name = "nginx2"
  }
}

#attachment
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