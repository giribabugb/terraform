
#modules
module "ec2" {
  source             = "../../modules/ec2"
  web_instance_count = 2
  #db_instance_count  = 2
  web_instance_type      = "t2.micro"
  #db_instance_type  = "t2.large"
  web-ports          = ["22", "80"]
  #db-ports           = ["22"]
  public_server_name  =  "pms-server"
  vpc_id        = module.vpc.vpc_id
  pub_subnet_id = module.vpc.subnet_id
  #prv_subnet_id = module.vpc.prv_subnet_id
}

module "vpc" {
  source             = "../../modules/vpc"
  #vpc_cidr          = "10.2.0.0/16"
  #pub_subnet_cidr   = "10.2.2.0/24"
  #prv_subnet_cidr   = "10.2.4.0/28"
  #azs               = "us-east-1b"
  #public_sub_names  = "test-public-Subnet1"
  #private_sub_names = "test-private-subnet"

  vpc_id        = module.vpc.vpc_id
  pub_subnet_id = module.vpc.subnet_id
  #prv_subnet_id = module.vpc.prv_subnet_id
}
