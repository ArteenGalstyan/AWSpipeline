# Terraform Outputs

output "server_ip" {
  description = "Web server public ip"
  value       = aws_instance.tf-demo-web-server.public_ip
}
