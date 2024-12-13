output "subnet_id" {
  description = "The subnet ID from the network module"
  value       = module.network.subnet_id
}

output "security_group_id" {
  description = "The security group ID from the network module"
  value       = module.network.security_group_id
}
output "public_ip" {
  description = "The public IP address from the eip module"
  value       = module.publicip.public_ip
}