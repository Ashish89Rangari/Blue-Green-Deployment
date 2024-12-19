# Below code show provider block information
# Not created provider.tf file
# Defines AWS as the cloud provider and sets the region to ap-south-1 (Mumbai).

provider "aws" {
  region = "ap-south-1"
}

# To create AWS EKS Cluster VPC
resource "aws_vpc" "devopsashu_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "devopsashu_vpc"           # Name of VPC
  }
}

# To create AWS EKS Cluster Subnet
# Creates 2 public subnets using a count loop.
# cidrsubnet() dynamically divides the VPC’s CIDR block into smaller subnets.
# Subnets are deployed across two availability zones (AZs): ap-south-1a and ap-south-1b.

resource "aws_subnet" "devopsashu_subnet" {
  count = 2
  vpc_id                  = aws_vpc.devopsashu_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.devopsashu_vpc.cidr_block, 8, count.index)
  availability_zone       = element(["ap-south-1a", "ap-south-1b"], count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "devopsashu-subnet-${count.index}"       # Name of Subnet
  }
}

# To create AWS EKS Cluster IGW
#Provides internet access to the resources within the VPC.

resource "aws_internet_gateway" "devopsashu_igw" {
  vpc_id = aws_vpc.devopsashu_vpc.id

  tags = {
    Name = "devopsashu-igw"             # Name of Internet gateway
  }
}

# To create AWS EKS Cluster Route table
# Configures a route table to direct all outbound traffic (0.0.0.0/0) to the IGW.

resource "aws_route_table" "devopsashu_route_table" {
  vpc_id = aws_vpc.devopsashu_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devopsashu_igw.id
  }

  tags = {
    Name = "devopsashu-route-table"          # Name of Route table
  }
}

# To create AWS EKS Cluster Route table association
#Associates the route table with both subnets for internet access.

resource "aws_route_table_association" "a" {
  count          = 2
  subnet_id      = aws_subnet.devopsashu_subnet[count.index].id
  route_table_id = aws_route_table.devopsashu_route_table.id
}

# To create AWS EKS Cluster Security Group
# Outbound (egress) traffic is unrestricted, allowing all protocols and IP ranges.

resource "aws_security_group" "devopsashu_cluster_sg" {
  vpc_id = aws_vpc.devopsashu_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devopsashu-cluster-sg"                # Name of Cluster Security Group
  }
}

# To create AWS EKS Cluster Node Security Group
# Unrestricted ingress and egress for the worker nodes.

resource "aws_security_group" "devopsashu_node_sg" {
  vpc_id = aws_vpc.devopsashu_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devopsashu-node-sg"                 # Name of Cluster Node Security Group
  }
}

# To create AWS EKS Cluster 
# Name of Cluster "devopsashu-cluster"
# Creates the Kubernetes control plane.
# Uses the subnets and cluster security group for network configuration.

resource "aws_eks_cluster" "devopsashu" {
  name     = "devopsashu-cluster"
  role_arn = aws_iam_role.devopsashu_cluster_role.arn

  vpc_config {
    subnet_ids         = aws_subnet.devopsashu_subnet[*].id
    security_group_ids = [aws_security_group.devopsashu_cluster_sg.id]
  }
}

# To create AWS EKS Cluster Node Group
# Name of Cluster "devopsashu-node-group"
# Configures a worker node group for the EKS cluster.
# Scaling Configuration: Fixed at 3 nodes, using t2.large instances.
# Allows SSH access using the key provided in var.ssh_key_name.


resource "aws_eks_node_group" "devopsashu" {
  cluster_name    = aws_eks_cluster.devopsashu.name
  node_group_name = "devopsashu-node-group"
  node_role_arn   = aws_iam_role.devopsashu_node_group_role.arn
  subnet_ids      = aws_subnet.devopsashu_subnet[*].id

  scaling_config {
    desired_size = 3
    max_size     = 3
    min_size     = 3
  }

  instance_types = ["t2.large"]

  remote_access {
    ec2_ssh_key = var.ssh_key_name
    source_security_group_ids = [aws_security_group.devopsashu_node_sg.id]
  }
}

# To create EKS Cluster Role
# Name of IAM role "devopsashu-cluster-role"
# Grants EKS permission to manage the cluster.

resource "aws_iam_role" "devopsashu_cluster_role" {
  name = "devopsashu-cluster-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Attach policy AmazonEKSClusterPolicy for cluster management.

resource "aws_iam_role_policy_attachment" "devopsashu_cluster_role_policy" {
  role       = aws_iam_role.devopsashu_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}


# To create EKS Cluster Node Group Role
# Name of IAM role "devopsashu-node-group-role"
# Grants EC2 instances permission to function as EKS worker nodes.


resource "aws_iam_role" "devopsashu_node_group_role" {
  name = "devopsashu-node-group-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Attach policy AmazonEKSWorkerNodePolicy for worker nodes management.

resource "aws_iam_role_policy_attachment" "devopsashu_node_group_role_policy" {
  role       = aws_iam_role.devopsashu_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

# Attach policy AmazonEKS_CNI_Policy for worker nodes management.

resource "aws_iam_role_policy_attachment" "devopsashu_node_group_cni_policy" {
  role       = aws_iam_role.devopsashu_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

# Attach policy AmazonEC2ContainerRegistryReadOnly for worker nodes management.

resource "aws_iam_role_policy_attachment" "devopsashu_node_group_registry_policy" {
  role       = aws_iam_role.devopsashu_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
