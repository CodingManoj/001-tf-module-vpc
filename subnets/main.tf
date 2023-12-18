# Creating Subnets
resource "aws_subnet" "main" {
  for_each          = var.subnets

  vpc_id            = var.vpc_id
  cidr_block        = each.value["cidr"]
  availability_zone = each.value["az"]

    tags = {
        Name = each.key
    }
}

# Creating Route Tables
resource "aws_route_table" "main" {
  for_each          = var.subnets

  vpc_id            = var.vpc_id
    tags = {
        Name = each.key
    }
}


# # Route table association to subnets
resource "aws_route_table_association" "a" {
  for_each          = var.subnets
  
  subnet_id         = lookup(lookup(aws_subnet.main, each.key, null), id, null)
  route_table_id    = lookup(lookup(aws_route_table.main, each.key, null), id, null)
}