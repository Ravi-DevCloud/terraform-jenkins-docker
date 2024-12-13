output "ebs_volume_id" {
    value = aws_ebs_volume.jenkins-data.id
}
output "ebs_volume_arn" {
    value = aws_ebs_volume.jenkins-data.arn
  
}