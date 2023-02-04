output "host-inventory" {
    description = "Public IP Addresses"
    value = [ for instance in aws_instance.demo_instance: instance.public_ip ]
}

# output "sec-grp" {
#   value = aws_security_group.allow_traffic.id
# }

# output "load_balancer_dns" {
#   value = aws_alb.demo_alb.dns_name
# }