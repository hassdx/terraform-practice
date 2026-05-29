module "network_security" {
  source = "./modules/network_security"
  vpc_id = module.network.vpc_id
}