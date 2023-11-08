module "vpc" {
  source   = "./modules/vpc"
  app_name = "challenge-fiap"
  env      = "dev"
}

module "eks" {
  source                 = "./modules/eks"
  eks_cluster_name       = "challenge-eks-cluster"
  eks_cluster_role_arn   = "arn:aws:iam::123456789012:role/eks-role" # Substitua pelo ARN do papel IAM correto
  subnet_ids             = [module.vpc.subnet_publica_id_a, module.vpc.subnet_publica_id_b]
  vpc_security_group_ids = [module.security_group_eks.id]
}

module "security_group_eks" {
  source = "./modules/security-group"

  name        = "challenge-fiap-eks"
  description = "Permite a conexao publica com eks "
  vpc_id      = module.vpc.id

  ingress_rules = [
    {
      description = "TCP eks Allowed"
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]

  egress_rules = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]
}
