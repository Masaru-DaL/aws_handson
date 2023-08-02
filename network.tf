# -----------------------------
# VPC
# -----------------------------
resource "aws_vpc" "vpc" {
  # 最大4,096個のホストアドレスを持つVPCを作成
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
  # VPC内のインスタンスがDNSサービスを利用できるかどうかの指定
  enable_dns_support = true
  # VPC内のインスタンスに対してDNSホスト名が付与されるかどうかの指定
  enable_dns_hostnames = true
  # VPCに自動生成されたIPv6 CIDRブロックを割り当てるかどうかの指定
  assign_generated_ipv6_cidr_block = false

  tags = {
    Name    = "${var.project}-${var.environment}-vpc"
    Project = var.project
    Env     = var.environment
  }
}

# -----------------------------
# subnet
# -----------------------------
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_public_cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name    = "${var.project}-${var.environment}-public-subnet"
    Project = var.project
    Env     = var.environment
  }
}

# resource "aws_subnet" "private_subnet" {
#   vpc_id                  = aws_vpc.vpc.id
#   cidr_block              = var.subnet_private_cidr_block
#   availability_zone       = var.availability_zone
#   map_public_ip_on_launch = false

#   tags = {
#     Name    = "${var.project}-${var.environment}-private-subnet"
#     Project = var.project
#     Env     = var.environment
#   }
# }

# -----------------------------
# Internet Gateway
# -----------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name    = "${var.project}-${var.environment}-igw"
    Project = var.project
    Env     = var.environment
  }
}

resource "aws_route" "public_rt_igw_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# -----------------------------
# Route table
# -----------------------------
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name    = "${var.project}-${var.environment}-public-rt"
    Project = var.project
    Env     = var.environment
    Type    = "public"
  }
}

resource "aws_main_route_table_association" "main_rt" {
  vpc_id         = aws_vpc.vpc.id
  route_table_id = aws_route_table.public_rt.id
}

# resource "aws_route_table" "private_rt" {
#   vpc_id = aws_vpc.vpc.id

#   tags = {
#     Name    = "${var.project}-${var.environment}-private-rt"
#     Project = var.project
#     Env     = var.environment
#     Type    = "private"
#   }
# }

# # NAT Gatewayに向けたルートを追加
# resource "aws_route" "private_rt_nat_gateway_route" {
#   route_table_id         = aws_route_table.private_rt.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = aws_nat_gateway.nat_gateway.id
# }

# resource "aws_route_table_association" "private_subnet_association" {
#   subnet_id      = aws_subnet.private_subnet.id
#   route_table_id = aws_route_table.private_rt.id
# }

# -----------------------------
# NAT Gateway
# -----------------------------
# resource "aws_eip" "nat_eip" {
#   vpc = true
# }

# resource "aws_nat_gateway" "nat_gateway" {
#   allocation_id = aws_eip.nat_eip.id
#   subnet_id     = aws_subnet.public_subnet.id

#   tags = {
#     Name    = "${var.project}-${var.environment}-nat-gateway"
#     Project = var.project
#     Env     = var.environment
#   }
# }
