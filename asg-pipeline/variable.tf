variable "ami_id" {
  default = "ami-013e83f579886baeb"
}

variable "instance_type" {
  default = "t2.micro"
}
variable "key_name" {
  type = string
  default = "dev"
}
