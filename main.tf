provider "aws" {
    region = var.aws_region
}

module "network" {
  source = "./modules/network"
  vpc_cidr_block = var.vpc_cidr_block
  subnet_cidr_block = var.subnet_cidr_block
  availability_zone = var.availability_zone
  ssh_port = var.ssh_port
  http_port = var.http_port
  jenkins_port = var.jenkins_port
  protocol = var.protocol
}

module "keypair" {
  source = "./modules/ec2-key-pair" 
}

module "ebs" {
  source = "./modules/ebs-volume"
  availability_zone_ebs = var.ebs_availability_zone
  volume_size = var.ebs_volume_size
}

module "ec2" {
  source = "./modules/ec2-instance"
  ami_id = var.instance_ami_id
  instance_type = var.instance_type
  public_subnet =   module.network.subnet_id
  security_groupid = [module.network.security_group_id]
  aws_key_pair = module.keypair.aws_key_pair
  depends_on = [ module.keypair ,module.ebs ]
}
resource "aws_volume_attachment" "jenkins-data-attachment" {
  device_name = "/dev/sdh"
  volume_id   = module.ebs.ebs_volume_id
  instance_id = module.ec2.instance_id
}

module "publicip" {
  source = "./modules/eip"
  publicip = module.ec2.instance_id
  
}


module "snapshot" {
  source = "./modules/ebs-snapshot"
  target_backup_id = module.ec2.instance_id
  target_ebs_volume_arn = module.ebs.ebs_volume_arn
}