output "cluster_id" {
  value = aws_eks_cluster.devopsashu.id
}

output "node_group_id" {
  value = aws_eks_node_group.devopsashu.id
}

output "vpc_id" {
  value = aws_vpc.devopsashu_vpc.id
}

output "subnet_ids" {
  value = aws_subnet.devopsashu_subnet[*].id
}

