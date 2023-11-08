resource "aws_iam_role" "eks_role" {
  name = "eks-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "eks_policy" {
  name        = "eks-cluster-policy"
  description = "Policy for EKS Cluster"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "eks:DescribeCluster",
          "eks:ListNodegroups",
          "eks:ListUpdates",
          "eks:CreateNodegroup",
          "eks:DeleteNodegroup",
        ],
        Effect   = "Allow",
        Resource = "*",
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "eks_policy_attachment" {
  name       = "eks-policy-attachment"
  roles      = [aws_iam_role.eks_role.name]
  policy_arn = aws_iam_policy.eks_policy.arn
}
