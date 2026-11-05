locals {
  all_instances = merge(
    aws_instance.protected,
    aws_instance.normal
  )
}

output "instance_ids" {
  value = {
    for name, instance in local.all_instances :
    name => instance.id
  }
}

output "private_ips" {
  value = {
    for name, instance in local.all_instances :
    name => instance.private_ip
  }
}