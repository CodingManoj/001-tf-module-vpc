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

output "subnets" {
    value = aws_subnet.main
}

# # Route table association to subnets
# resource "aws_route_table_association" "a" {
#   for_each          = var.subnets
  
#   subnet_id         = lookup(aws_subnet.main, id, null)
#   route_table_id    = 
# }