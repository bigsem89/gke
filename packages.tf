resource "helm_release" "kube-prometheus-stack" {
  name       = "kube-prometheus-stack"
  create_namespace = true
  dependency_update = true
  cleanup_on_fail = true
  namespace = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version = "44"#"19.3"
  wait = true
  wait_for_jobs = true

#  set {
#    name  = "namespace"
#    value = "prometheus"
#  }
  depends_on = [
    google_container_cluster.cluster
  ]
}

#resource "helm_release" "grafana" {
#  name       = "grafana"
#  create_namespace = true
#  dependency_update = true
#  cleanup_on_fail = true
#  namespace = "monitoring"
#  repository = "https://grafana.github.io/helm-charts"
#  chart      = "grafana"
#  values = [
#    file("grafana-values/values.yaml")
#  ]
#
##  set {
##    name  = "namespace"
##    value = "prometheus"
##  }
#  depends_on = [
#    google_container_cluster.cluster
#  ]
#}