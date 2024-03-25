# contentserver

![Version: 0.0.3-rc.1](https://img.shields.io/badge/Version-0.0.3--rc.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.11.0-rc.10](https://img.shields.io/badge/AppVersion-1.11.0--rc.10-informational?style=flat-square)

Helm chart for the foomo Content Server.

**Homepage:** <https://www.foomo.org>

## Resources

- [Source](https://github.com/foomo/helm-charts)
- [GTM Changelog](https://developers.google.com/tag-platform/tag-manager/server-side/release-notes)

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| config.address | string | `":8080"` | - Address to bind to host:port |
| config.basePath | string | `"/contentserver"` | Path to export the webserver on |
| config.repository.poll | bool | `false` | - If true, the address arg will be used to periodically poll the content url e.g. http://contentserverexport:8080/poll-revision |
| config.repository.pollInterval | string | `"60s"` | - Update poll interval |
| config.repository.url | string | `"http://contentserverexport:8080"` | Repository server url |
| contentserver.affinity | object | `{}` | Affinity settings for pods. |
| contentserver.autoscaling.behavior.enabled | bool | `false` | Enable autoscaling behaviours |
| contentserver.autoscaling.behavior.scaleDown | object | `{}` | Scale down policies, must conform to HPAScalingRules |
| contentserver.autoscaling.behavior.scaleUp | object | `{}` | Scale up policies, must conform to HPAScalingRules |
| contentserver.autoscaling.customMetrics | list | `[]` | Custom metrics using the HPA/v2 schema (for example, Pods, Object or External metrics) |
| contentserver.autoscaling.enabled | bool | `false` | Enable autoscaling |
| contentserver.autoscaling.maxReplicas | int | `100` | Maximum autoscaling replicas |
| contentserver.autoscaling.minReplicas | int | `1` | Minimum autoscaling replicas |
| contentserver.autoscaling.targetCPUUtilizationPercentage | int | `80` | Target CPU utilisation percentage |
| contentserver.autoscaling.targetMemoryUtilizationPercentage | string | `nil` | Target memory utilisation percentage |
| contentserver.dnsConfig | object | `{}` | DNSConfig settings for pods. |
| contentserver.extraArgs | list | `[]` | Arguements to add |
| contentserver.extraEnv | list | `[]` | Environment variables to add |
| contentserver.extraEnvFrom | list | `[]` | Environment variables from secrets or configmaps to add |
| contentserver.extraPorts | list | `[]` | Port definitions to add |
| contentserver.extraVolumeMounts | list | `[]` | Volume mounts to add |
| contentserver.extraVolumes | list | `[]` | Volumes to add |
| contentserver.hostAliases | list | `[]` | Host aliases to add |
| contentserver.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| contentserver.image.repository | string | `"foomo/contentserver"` | The image repository |
| contentserver.image.tag | string | `"1.11.0-rc.10"` | The image tag |
| contentserver.imagePullSecrets | list | `[]` | Image pull secrets |
| contentserver.livenessProbe | object | `{"httpGet":{"path":"/healthz/liveness","port":9400}}` | Liveness probe settings for pods. |
| contentserver.maxUnavailable | string | `nil` | Pod Disruption Budget maxUnavailable |
| contentserver.nodeSelector | object | `{}` | Tolerations settings for pods. |
| contentserver.podAnnotations | object | `{}` | Annotations for pods |
| contentserver.podLabels | object | `{}` | Labels for pods |
| contentserver.podSecurityContext | object | `{}` | The SecurityContext for pods |
| contentserver.readinessProbe | object | `{"httpGet":{"path":"/healthz/readiness","port":9400}}` | Readiness probe settings for pods. |
| contentserver.replicaCount | int | `1` | Number of replicas |
| contentserver.resources | object | `{}` | Resource request & limits. |
| contentserver.roll | bool | `false` | Always roll your deployment |
| contentserver.securityContext | object | `{}` |  |
| contentserver.service.annotations | object | `{}` | Annotations for the service |
| contentserver.service.labels | object | `{}` | Labels for service |
| contentserver.service.port | int | `8080` | Port of the service |
| contentserver.service.type | string | `"ClusterIP"` | Type of the service |
| contentserver.startupProbe | object | `{"httpGet":{"path":"/healthz/startup","port":9400}}` | Startup probe settings for pods. |
| contentserver.terminationGracePeriodSeconds | int | `30` | - Termination grace period in seconds |
| contentserver.tolerations | list | `[]` | Tolerations settings for pods. |
| fullnameOverride | string | `""` | Overrides the chart's computed fullname |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0] | string | `"example.com"` |  |
| ingress.paths[0].path | string | `"/contentserver"` |  |
| ingress.paths[0].pathType | string | `"Prefix"` |  |
| ingress.paths[0].port | int | `8080` |  |
| ingress.tls | list | `[]` |  |
| nameOverride | string | `""` | Overrides the chart's name |
| namespaceOverride | string | `""` | The name of the Namespace to deploy If not set, `.Release.Namespace` is used |
| networkPolicy.discovery.namespaceSelector | object | `{}` | Specifies the namespace the discovery Pods are running in |
| networkPolicy.discovery.podSelector | object | `{}` | Specifies the Pods labels used for discovery. As this is cross-namespace communication, you also need the namespaceSelector. |
| networkPolicy.discovery.port | string | `nil` | Specify the port used for discovery |
| networkPolicy.enabled | bool | `false` | Specifies whether Network Policies should be created |
| networkPolicy.externalStorage.cidrs | list | `[]` | Specifies specific network CIDRs you want to limit access to |
| networkPolicy.externalStorage.ports | list | `[]` | Specify the port used for external storage, e.g. AWS S3 |
| networkPolicy.ingress.namespaceSelector | object | `{}` | Specifies the namespaces which are allowed to access the http port |
| networkPolicy.ingress.podSelector | object | `{}` | Specifies the Pods which are allowed to access the http port. As this is cross-namespace communication, you also need the namespaceSelector. |
| networkPolicy.metrics.cidrs | list | `[]` | Specifies specific network CIDRs which are allowed to access the metrics port. In case you use namespaceSelector, you also have to specify your kubelet networks here. The metrics ports are also used for probes. |
| networkPolicy.metrics.namespaceSelector | object | `{}` | Specifies the namespaces which are allowed to access the metrics port |
| networkPolicy.metrics.podSelector | object | `{}` | Specifies the Pods which are allowed to access the metrics port. As this is cross-namespace communication, you also need the namespaceSelector. |
| otel.enabled | bool | `false` | - Otel enabled |
| otel.otlp.enabled | bool | `true` | - OTLP export enabled |
| otel.otlp.endpoint | string | `""` | - OTLP exporter endpoint |
| otel.otlp.insecure | bool | `true` | - OTLP insecure exporter |
| otel.ratio | int | `1` | - Trace collect ratio |
| persistence.accessModes | list | `["ReadWriteOnce"]` | Access modes for the PVC |
| persistence.annotations | object | `{}` | Annotations for the PVC |
| persistence.enabled | bool | `false` | Enable persistent storage |
| persistence.labels | object | `{}` | Labels for the PVC |
| persistence.path | string | `"/var/lib/contentserver"` | - File storage location |
| persistence.size | string | `"1Gi"` | Storage size |
| persistence.storageClass | string | `""` | - Storage class to be used |
| rbac.enabled | bool | `false` | Create PodSecurityPolicy. |
| revisionHistoryLimit | int | `10` | Number of revisions to retain to allow rollback |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.automount | bool | `true` | Automatically mount a ServiceAccount's API credentials? |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | If not set and create is true, a name is generated using the fullname template |
| serviceMonitor.annotations | object | `{}` | ServiceMonitor annotations |
| serviceMonitor.enabled | bool | `false` | If enabled, ServiceMonitor resources for Prometheus Operator are created |
| serviceMonitor.interval | string | `nil` | ServiceMonitor scrape interval |
| serviceMonitor.labels | object | `{}` | Additional ServiceMonitor labels |
| serviceMonitor.matchExpressions | list | `[]` | Optional expressions to match on |
| serviceMonitor.metricRelabelings | list | `[]` | ServiceMonitor metric relabel configs to apply to samples before ingestion https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/api.md#endpoint |
| serviceMonitor.namespace | string | `nil` | Alternative namespace for ServiceMonitor resources |
| serviceMonitor.namespaceSelector | object | `{}` | Namespace selector for ServiceMonitor resources |
| serviceMonitor.relabelings | list | `[]` | ServiceMonitor relabel configs to apply to samples before scraping https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/api.md#relabelconfig |
| serviceMonitor.scheme | string | `"http"` | ServiceMonitor will use http by default, but you can pick https as well |
| serviceMonitor.scrapeTimeout | string | `nil` | ServiceMonitor scrape timeout in Go duration format (e.g. 15s) |
| serviceMonitor.targetLabels | list | `[]` |  |
| serviceMonitor.tlsConfig | string | `nil` | ServiceMonitor will use these tlsConfig settings to make the health check requests |
