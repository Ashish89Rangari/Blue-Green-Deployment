
# provides visibility into critical information about the infrastructure created.
# such as cluster id, node group id etc
# It outputs resource attributes or computed values, making them accessible after deployment. 


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

