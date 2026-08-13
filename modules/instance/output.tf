output "instance_id" {
  description = "ID of the created EC2 instance"
  value       = aws_instance.this.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.this.public_ip
}

output "vpc_id" {
  description = "ID of the default VPC used"
  value       = data.aws_vpc.default.id
}

output "subnet_id" {
  description = "ID of the subnet used"
  value       = data.aws_subnets.default.ids[0]
}

