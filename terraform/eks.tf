#Creating EKS Cluster
resource "aws_eks_cluster" "eks" {
  name     = "pc-eks"
  role_arn = aws_iam_role.master.arn

  vpc_config {
    subnet_ids = [aws_subnet.Mysubnet01.id, aws_subnet.Mysubnet02.id]
  }

  tags = {
    "Name" = "MyEKS"
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSServicePolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
  ]
}

resource "aws_instance" "kubectl-server" {
  ami                         = "ami-0135026717542797f"  # Replace with a valid AMI ID for ap-south-1 region
  key_name                    = var.ssh_key  # Make sure the key pair exists in ap-south-1 region
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.Mysubnet01.id
  vpc_security_group_ids      = [aws_security_group.allow_tls.id]

  tags = {
    Name = "kubectl"
  }
}

resource "aws_eks_node_group" "node-grp" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "pc-node-group"
  node_role_arn   = aws_iam_role.worker.arn
  subnet_ids      = [aws_subnet.Mysubnet01.id, aws_subnet.Mysubnet02.id]
  capacity_type   = "ON_DEMAND"
  disk_size       = 20
  instance_types  = ["t2.small"]

  remote_access {
    ec2_ssh_key               = var.ssh_key
    source_security_group_ids = [aws_security_group.allow_tls.id]
  }

  labels = {
    env = "dev"
  }

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}