ami_id = "ami-xxxxxxxxxxxxxxxxx"

instances = {
  ec2-development = {
    instance_type = "t3.micro"
    volume_type   = "gp3"
    volume_size   = 20
    key_name      = "dev-key"
    environment   = "development"
    owner         = "DevOps"
  }

  ec2-testing = {
    instance_type = "t3.small"
    volume_type   = "gp2"
    volume_size   = 30
    key_name      = "test-key"
    environment   = "testing"
    owner         = "DevOps"
  }

  ec2-staging = {
    instance_type = "t3.medium"
    volume_type   = "gp3"
    volume_size   = 40
    key_name      = "staging-key"
    environment   = "staging"
    owner         = "DevOps"
  }

  ec2-production = {
    instance_type = "m5.large"
    volume_type   = "io1"
    volume_size   = 50
    iops          = 3000
    key_name      = "production-key"
    environment   = "production"
    owner         = "SRE"
    protect       = true
  }

  ec2-monitoring = {
    instance_type = "c5.large"
    volume_type   = "gp3"
    volume_size   = 60
    key_name      = "monitoring-key"
    environment   = "monitoring"
    owner         = "SRE"
  }
}