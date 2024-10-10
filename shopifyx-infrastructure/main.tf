provider "aws" {
  region     = "us-east-1"
}

# cidr block var.vpc_cidr_block
# VPC
resource "aws_vpc" "shopifyx_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "shopifyx_vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "shopifyx_igw" {
  vpc_id = aws_vpc.shopifyx_vpc.id

  tags = {
    Name = "shopifyx_igw"
  }
}

# Public Subnets
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.shopifyx_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Public-subnet"
  }
}




# Route Table for Public Subnets
resource "aws_route_table" "shopifyx_public_rt" {
  vpc_id = aws_vpc.shopifyx_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.shopifyx_igw.id
  }

  tags = {
    Name = "shopifyx_public_rt"
  }
}

# Associate Public Subnets with Route Table public_subnet count ass_public_subnet_assoc [count.index]
resource "aws_route_table_association" "shopifyx_public_subnet_assoc" {
  count          = length(aws_subnet.main)
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.shopifyx_public_rt.id
}

# Security Group for Frontend Servers (HTTP/HTTPS access)
resource "aws_security_group" "shopifyx_frontend_sg" {
  vpc_id = aws_vpc.shopifyx_vpc.id

  ingress {
    description      = "Allow HTTP traffic"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Allow HTTPS traffic"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "shopifyx_frontend_sg"
  }
}

# Security Group for Backend Servers (SSH access)
resource "aws_security_group" "shopifyx_backend_sg" {
  vpc_id = aws_vpc.shopifyx_vpc.id

  ingress {
    description      = "Allow SSH traffic"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "backend_sg"
  }
}


# Backend Servers subnet id [0] key_name,  key_name      = var.terraform_ass_kp.pem  # Ensure you have a key pair specified
resource "aws_instance" "shopifyx_backend_servers" {
  count         = 2  # Number of backend servers to be created
  ami           = "ami-0866a3c8686eaeeba"  # Replace with a valid AMI ID for your region
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main.id  # Using the first public subnet for backend servers
  vpc_security_group_ids = [aws_security_group.shopifyx_backend_sg.id]

  tags = {
    Name = "shopifyx-backend-server-${count.index}"
  }
}



# Frontend Servers
resource "aws_instance" "shopifyx_frontend_servers" {
  count         = 1
  ami           = "ami-0866a3c8686eaeeba"  # Replace with a valid AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main.id  # Use the same subnet as backend servers
  vpc_security_group_ids = [aws_security_group.shopifyx_frontend_sg.id]

  tags = {
    Name = "shopifyx-frontend-server-${count.index}"
  }
}


# S3 Bucket
resource "aws_s3_bucket" "shopifyx_bucket" {
  bucket = "shopifyx-s3buc-12345"  # Ensure this bucket name is globally unique

  tags = {
    Name        = "shopifyx_bucket"
    Environment = "dev"
  }
}