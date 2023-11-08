resource "aws_eks_cluster" "eks_cluster" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.eks_role.arn
  vpc_config {
    subnet_ids = var.subnet_ids
    security_group_ids = var.vpc_security_group_ids
  }
  tags = {
    Name = var.eks_cluster_name
  }
}