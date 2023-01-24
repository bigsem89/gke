

resource "helm_release" "kube-prometheus-stack" {
  name       = "kube-prometheus-stack"
  dependency_update = true
  cleanup_on_fail = true
  namespace = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version = "44.3"#"19.3"
  wait = true
  wait_for_jobs = true
  values = [file("k8s/values-some.yaml")]

  depends_on = [
    google_container_cluster.cluster,
    kubernetes_namespace.monitoring
  ]
}

resource "kubernetes_namespace" "myapp" {
  metadata {
    name = "myapp"
    labels = {
      prometheus: "true"
    }
  }
}


resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
    labels = {
      prometheus: "true"
    }
  }
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