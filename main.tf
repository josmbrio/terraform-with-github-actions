data "aws_vpc" "current-default" {
    default = true
}

resource "aws_security_group" "my-sg" {
  name        = "my-sg-jbr"
  description = "Allow TLS inbound traffic"
  vpc_id      = data.aws_vpc.current-default.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [data.aws_vpc.current-default.cidr_block]
    ipv6_cidr_blocks = [data.aws_vpc.current-default.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}