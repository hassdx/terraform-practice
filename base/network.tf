module "network" {
  source        = "./modules/network"
  vpc_cidr      = "10.10.0.0/16"
  name          = "HASSAN-ELHOUARI-01"
  subnet_cidr_a = "10.10.1.0/24"
  subnet_cidr_b = "10.10.3.0/24"
  subnet_cidr_c = "10.10.5.0/24"
}
