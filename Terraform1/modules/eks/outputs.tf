output "endpoint" {
  value = aws_eks_cluster.hostspace.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.hostspace.certificate_authority[0].data
}
output "cluster_id" {
  value = aws_eks_cluster.hostspace.id
}
output "cluster_endpoint" {
  value = aws_eks_cluster.hostspace.endpoint
}
output "cluster_name" {
  value = aws_eks_cluster.hostspace.name
}