resource "aws_vpc" "main" {
    cidr_block   = var.cidr 
}

module "subnets" {
    for_each = var.subnets

    source   = "./subnets"
    subnets  = var.subnets
    vpc_id   = aws_vpc.main.id 
}