data "aws_vpc" "main" {
  default = var.vpc_name == "" ? true : false

  tags = var.vpc_name != "" ? {
    Name = "${var.vpc_name}"
  } : {}
}

data "aws_ami" "ami" {
  most_recent = true

  filter {
    name = "name"

    values = [var.ami]
  }

  owners = [var.ami_owner]
}

data "aws_security_group" "group" {
  filter {
    name   = "group-name"
    values = var.security_groups
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
}

data "aws_subnet_ids" "subnets" {
  vpc_id = data.aws_vpc.main.id
}

