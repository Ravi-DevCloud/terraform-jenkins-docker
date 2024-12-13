resource "aws_eip" "public-ip" {
  instance = var.publicip
}
