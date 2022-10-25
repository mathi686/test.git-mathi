output "output-vpc-id" {
  value = aws_vpc.firstVPC.id
}
#output "output-ec2-ip" {
  #value = aws_instance.my-ec2-terraform.public_ip
#}
output "secg-id" {
  value = aws_security_group.mysecgp.id
}
#output "ip-private" {
  #value = aws_instance.my-ec2-terraform.private_ip
#}
output "public-ip" {
  value = aws_instance.my-ec2-terraform.public_ip
}
#output "private-2nd-instance" {
  #value = aws_instance.my-c2-multipe.private_ip
#}
#output "second-instance-public-ip" {
  #value = aws_instance.my-c2-multipe.public_ip
#}
output "INS-ID" {
  value = aws_instance.my-ec2-terraform.id
}