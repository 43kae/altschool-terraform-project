resource "aws_vpc" "demo_vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = "demo_vpc"
  }
}

resource "aws_subnet" "demo_subnet" {
  for_each = var.subnets
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = each.value["cidr"]
  availability_zone = each.value["az"]

  tags = {
    Name = "${each.key}"
  }
}

resource "aws_internet_gateway" "demo_igw" {
  vpc_id = aws_vpc.demo_vpc.id

  tags = {
    Name = "demo_igw"
  }
}

resource "aws_route_table" "demo_rt" {
  vpc_id = aws_vpc.demo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo_igw.id
  }

  tags = {
    Name = "demo-route-table"
  }
}

resource "aws_route_table_association" "demo_rt_assoc" {
  for_each = var.subnets
  subnet_id = aws_subnet.demo_subnet[each.key].id
  route_table_id = aws_route_table.demo_rt.id
}