 resource "aws_vpc" "project_1" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"

    tags = {
        Name = "project-1"
    }  
 }

 resource "aws_subnet" "public_subnet1" {
    vpc_id = aws_vpc.project_1.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "eu-west-1a"
    map_public_ip_on_launch = true


    tags = {
        Name= "public-subnet1"
    }
 }


 resource "aws_subnet" "public_subnet2" {
    vpc_id = aws_vpc.project_1.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "eu-west-1b"
    map_public_ip_on_launch = true

    tags = {
        Name= "public-subnet2"
    }
 }

 resource "aws_internet_gateway_attachment" "gw_attachment" {
    internet_gateway_id = aws_internet_gateway.gw.id
    vpc_id = aws_vpc.project_1.id
 }

resource "aws_internet_gateway" "gw"{

}

resource "aws_route" "project_1_route" {
    route_table_id = aws_vpc.project_1.default_route_table_id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
}

