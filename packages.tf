resource "helm_release" "prometheus" {
  name       = "v1"
  create_namespace = true
  dependency_update = true
  cleanup_on_fail = true
  namespace = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  version = "19.3"

#  set {
#    name  = "namespace"
#    value = "prometheus"
#  }
  depends_on = [
    google_container_cluster.cluster
  ]
}