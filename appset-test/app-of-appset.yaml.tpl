apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: xiq-portal
  namespace: portal
spec:
  project: xiq
  sources:
  - repoURL: https://charts.xcloudiq.com/charts/xiq
    chart: appset-portal
    targetRevision: {{ VERSION }}
    helm:
      valueFiles:
      - $values/xiq/global.yaml
      - $values/xiq/{{ CLUSTER }}/portal/global.yaml
      - $values/xiq/{{ CLUSTER }}/portal/appset.yaml
  - repoURL: git@github.com:extremenetworks/xcloud-appconfig.git
    targetRevision: main
    ref: values
  destination:
    server: https://kubernetes.default.svc
    namespace: portal
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
