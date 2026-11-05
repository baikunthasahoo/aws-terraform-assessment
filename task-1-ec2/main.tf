module "ec2" {
  source = "./modules/ec2"

  ami_id    = var.ami_id
  instances = var.instances
}