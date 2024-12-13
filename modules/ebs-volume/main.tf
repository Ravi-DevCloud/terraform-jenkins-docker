resource "aws_ebs_volume" "jenkins-data" {
  availability_zone = var.availability_zone_ebs
  size              = var.volume_size

  tags = {
    Name = "jenkins-data-volume"
    Backup = "true"
  }
  
}
