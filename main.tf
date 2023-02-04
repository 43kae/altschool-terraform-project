#Creates instances in each subnet

resource "aws_instance" "demo_instance" {
    for_each = var.subnets
    ami  = "ami-00874d747dde814fa"
    instance_type = "t2.micro"
    tags = {
        Name = "demo_instance"
    }
    key_name = "altschool-aws-key"
    subnet_id = aws_subnet.demo_subnet[each.key].id
    availability_zone = each.value["az"]
    associate_public_ip_address = true
    security_groups = [
        aws_security_group.demo_sec_grp.id
    ]
}


#Code to parse the public_ips to a new file "host inventory"
# resource "local_file" "host_inventory" {
#   filename = "./host-inventory"
#   content  = aws_instance.demo_instance[var.subnets].public_ip
# }

#Can't find a way to make it work yet, so I used the command in jq-cmd to 
#parse and format the terraform output
