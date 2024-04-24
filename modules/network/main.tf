resource "aws_vpc" "eks-deployment" {
  cidr_block = "192.168.0.0/16"

  tags = {
    Name = "eks-deployment-vpc"
  }
}

resource "aws_subnet" "public-subnet-1" {
  vpc_id               = aws_vpc.eks-deployment.id
  cidr_block           = "192.168.0.0/18"
  availability_zone_id = "aps1-az1"

  tags = {
    Name = "Public Subnet 1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id               = aws_vpc.eks-deployment.id
  cidr_block           = "192.168.64.0/18"
  availability_zone_id = "aps1-az2"

  tags = {
    Name = "Public Subnet 2"
  }
}

resource "aws_subnet" "private-subnet-1" {
  vpc_id               = aws_vpc.eks-deployment.id
  cidr_block           = "192.168.128.0/18"
  availability_zone_id = "aps1-az1"

  tags = {
    Name = "Private Subnet 1"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id               = aws_vpc.eks-deployment.id
  cidr_block           = "192.168.192.0/18"
  availability_zone_id = "aps1-az2"

  tags = {
    Name = "Private Subnet 2"
  }
}

# Internet Gateway -------------------------------------->

resource "aws_internet_gateway" "eks-ig" {
  vpc_id = aws_vpc.eks-deployment.id

  tags = {
    Name = "EKS Internet Gateway"
  }
}

# Internet Gateway -------------------------------------->


# NAT Gateways ------------------------------------------>

resource "aws_eip" "nat-gateway-1" {}

resource "aws_eip" "nat-gateway-2" {}

resource "aws_nat_gateway" "public-subnet-1" {
  subnet_id         = aws_subnet.public-subnet-1.id
  connectivity_type = "public"
  allocation_id     = aws_eip.nat-gateway-1.id

  depends_on = [aws_internet_gateway.eks-ig]

  tags = {
    Name = "Public Subnet 1 NAT Gateway"
  }
}

resource "aws_nat_gateway" "public-subnet-2" {
  subnet_id         = aws_subnet.public-subnet-2.id
  connectivity_type = "public"
  allocation_id     = aws_eip.nat-gateway-2.id

  depends_on = [aws_internet_gateway.eks-ig]

  tags = {
    Name = "Public Subnet 2 NAT Gateway"
  }
}

# NAT Gateways ------------------------------------------>


# Route Tables ------------------------------------------>

resource "aws_route_table" "public-subnet-rt" {
  vpc_id = aws_vpc.eks-deployment.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks-ig.id
  }

  tags = {
    Name = "Public Subnet Route Table"
  }
}

resource "aws_route_table_association" "public-subnet-1" {
  route_table_id = aws_route_table.public-subnet-rt.id
  subnet_id      = aws_subnet.public-subnet-1.id
}

resource "aws_route_table_association" "public-subnet-2" {
  route_table_id = aws_route_table.public-subnet-rt.id
  subnet_id      = aws_subnet.public-subnet-2.id
}



resource "aws_route_table" "private-subnet-1" {
  vpc_id = aws_vpc.eks-deployment.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public-subnet-1.id
  }

  tags = {
    Name = "Private Subnet 1 Route Table"
  }
}

resource "aws_route_table_association" "private-subnet-1" {
  route_table_id = aws_route_table.private-subnet-1.id
  subnet_id      = aws_subnet.private-subnet-1.id
}



resource "aws_route_table" "private-subnet-2" {
  vpc_id = aws_vpc.eks-deployment.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public-subnet-2.id
  }

  tags = {
    Name = "Private Subnet 2 Route Table"
  }
}

resource "aws_route_table_association" "private-subnet-2" {
  route_table_id = aws_route_table.private-subnet-2.id
  subnet_id      = aws_subnet.private-subnet-2.id
}

# Route Tables ------------------------------------------>
