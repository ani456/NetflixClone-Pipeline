data "aws_vpc" "default" {
  default = true
  //tells Terraform to find the AWS-provided default VPC in your account/region and 
  //expose its attributes           
}

# Use the default subnet within the default VPC (first available AZ)
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "default-for-az" //returns the default subnet in each Availability Zone
    values = ["true"]
  }
}

# Fetch the latest Amazon Linux 2023 AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] ##Canonical is offical ami owner 

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-resolute-26.04-amd64-server-*"]
    ##for this go in the ami section in public filter search of ami-<id of the ami>
  }
}

# Security group allowing SSH access 
resource "aws_security_group" "this" {              ##this is just name to reference the resource in the module, not the actual name of the security group##0
  name        = "${var.project_name}-sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Restrict this to your IP in production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-sg"
  }
}

# EC2 instance
resource "aws_instance" "this" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = [aws_security_group.this.id]
  key_name               = var.key_name

  tags = {
    Name = var.instance_name
  }
}
