variable "vpc_cidr_block" {
  description = "cidr block for the vpc"
  type        = string
}

variable "subnet_cidr_block" {
  description = "cidr block for the subnet1"
  type        = string
}
variable "availability_zone" {
  description = "availability zone for the subnet1"
  type        = string
}

variable "ssh_port" {
  description = "Port for SSH access"
  type        = number
  default     = 22
}

variable "http_port" {
  description = "Port for HTTP access"
  type        = number
  default     = 80
}

variable "jenkins_port" {
  description = "Port for Jenkins"
  type        = number
  default     = 8080
}

variable "protocol" {
  type        = string
  description = "value for protocol"
}
variable "ingress_cidr_block" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
variable "engress_cidr_block" {
  type    = list(string)
  default = ["0.0.0.0/0"]

}