output "public_ip" {
    value = aws_eip.public-ip.public_ip
}