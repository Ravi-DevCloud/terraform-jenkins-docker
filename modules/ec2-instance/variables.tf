variable "ami_id" {
  description = "ami id"
  type        = string
}
variable "instance_type" {
  description = "instance type"
  type        = string

}
variable "aws_key_pair" {
  description = "key pair"
  type        = string
}
variable "public_subnet" {
  description = "public subnet"
  type        = string
}
variable "security_groupid" {
  description = "security group id"
  type        = list(string)  
}