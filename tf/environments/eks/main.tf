
module "vpc" {
  source           = "../../modules/vpc"
  vpc_name         = "eks_vpc"
  igw_name         = "eks_igw"
  vpc_cidr         = "10.2.0.0/16"
  pub_subnet_cidr  = ["10.2.1.0/24", "10.2.2.0/24"]
  azs              = ["us-east-1a", "us-east-1b"]
  public_sub_names = ["eks-worker-node-1", "eks-worker-node-2"]

}



module "eks" {
  source          = "../../modules/eks"
  cluster_name    = "eks"
  node_group_name = "eks-node"
  instance_type   = "t2.medium"
  desired_size    = 2

  max_size      = 3
  min_size      = 1
  pub_subnet_id = module.vpc.subnet_id[*]

}

