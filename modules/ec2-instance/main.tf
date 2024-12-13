resource "aws_instance" "jenkins-server" {
    ami           = var.ami_id
    instance_type = var.instance_type
    key_name      = var.aws_key_pair
    vpc_security_group_ids = var.security_groupid
    subnet_id = var.public_subnet
    tags = {    
      Name = "jenkins-server"
    }
  user_data = <<-EOF
        #!/bin/bash

        # Update the package lists
        sudo apt update -y

        # Install Docker and Docker Csompose
        sudo apt install docker.io docker-compose -y
        sudo usermod -aG docker ubuntu

        # Start the Docker service
        sudo systemctl start docker

        # Enable the Docker service to start on boot
        sudo systemctl enable docker

        # Clone your GitHub repository containing the Docker Compose file
        git clone https://github.com/Ravi-DevCloud/terraform-jenkins-docker.git

        # Navigate to the project directory
        cd terraform-jenkins-docker

        # Start Jenkins using Docker Compose
        docker-compose up -d
    EOF
  
}
