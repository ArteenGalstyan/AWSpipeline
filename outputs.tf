# Terraform Outputs

output "server_private_ip" {
  value = aws_instance.tf-demo-web-server.private_ip

}

output "server_id" {
  value = aws_instance.tf-demo-web-server.id
}
