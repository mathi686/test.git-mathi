variable "tag" {
  description = "providing tags to all resources"
  type = string
  default = "Prod-vpc,sub1,sub2"
}
variable "vpc" {
  description = "changing vpc cidr value"
  type = string
  default = "10.0.0.0/24"

}
variable "availzoon1" {
  description = "changing zone"
  type = string
  default = "us-east-2b"
}




