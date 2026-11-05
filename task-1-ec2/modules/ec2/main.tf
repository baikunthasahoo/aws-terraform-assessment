locals {
  protected_instances = {
    for name, config in var.instances :
    name => config if config.protect
  }

  normal_instances = {
    for name, config in var.instances :
    name => config if !config.protect
  }
}

resource "aws_instance" "protected" {
  for_each = local.protected_instances

  ami           = var.ami_id
  instance_type = each.value.instance_type
  key_name      = each.value.key_name

  root_block_device {
    volume_type = each.value.volume_type
    volume_size = each.value.volume_size
    iops        = each.value.iops
    encrypted   = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = each.key
    Environment = each.value.environment
    Owner       = each.value.owner
  }
}

resource "aws_instance" "normal" {
  for_each = local.normal_instances

  ami           = var.ami_id
  instance_type = each.value.instance_type
  key_name      = each.value.key_name

  root_block_device {
    volume_type = each.value.volume_type
    volume_size = each.value.volume_size
    iops        = each.value.iops
    encrypted   = true
  }

  tags = {
    Name        = each.key
    Environment = each.value.environment
    Owner       = each.value.owner
  }
}