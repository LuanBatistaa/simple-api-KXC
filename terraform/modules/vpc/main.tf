
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "my-igw"
  }
}

resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-${count.index + 1}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "public-rt"
  }
}


resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}


resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}


resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index % length(var.azs)]

  tags = {
    Name = "private-${count.index + 1}"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

locals {
  # Agrupa todas as subnets privadas por AZ.
  # Isso só funciona se você tem uma sub-rede privada por AZ (o que é o ideal).
  private_subnets_by_az = {
    for s in aws_subnet.private : s.availability_zone => s.id...
  }

  # Pega só a primeira subnet de cada AZ, resultando em uma lista [subnet_az_a, subnet_az_b, ...]
  private_subnets_one_per_az = [
    for az, subnets in local.private_subnets_by_az : subnets[0]
  ]

  # Divide a lista de sub-redes na metade para evitar conflitos de AZ.
  # Usaremos este grupo para ECR API e CLOUDWATCH LOGS (se criado).
  private_subnets_group_1 = slice(local.private_subnets_one_per_az, 0, ceil(length(local.private_subnets_one_per_az) / 2))

  # Usaremos este grupo para ECR DKR.
  private_subnets_group_2 = slice(local.private_subnets_one_per_az, ceil(length(local.private_subnets_one_per_az) / 2), length(local.private_subnets_one_per_az))
}

# 1. ECR API (Grupo 1)
resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id              = aws_vpc.this.id
  service_name        = "com.amazonaws.${var.aws_region}.ecr.api"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = local.private_subnets_group_1 
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.ecs_sg.id]
}

# 2. ECR DKR (Grupo 2)
resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id              = aws_vpc.this.id
  service_name        = "com.amazonaws.${var.aws_region}.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = local.private_subnets_group_2
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.ecs_sg.id]
}

# 3. S3 GATEWAY (Não precisa de alteração)
resource "aws_vpc_endpoint" "s3_gateway" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_route_table.private.id] 
}