# sesamy-gtm-enrichment

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

Helm chart for your custom Sesamy GTM enrichment service.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| enrichment.affinity | object | `{}` | Affinity settings for pods. |
| enrichment.autoscaling.behavior.enabled | bool | `false` | Enable autoscaling behaviours |
| enrichment.autoscaling.behavior.scaleDown | object | `{}` | Scale down policies, must conform to HPAScalingRules |
| enrichment.autoscaling.behavior.scaleUp | object | `{}` | Scale up policies, must conform to HPAScalingRules |
| enrichment.autoscaling.customMetrics | list | `[]` | Custom metrics using the HPA/v2 schema (for example, Pods, Object or External metrics) |
| enrichment.autoscaling.enabled | bool | `false` | Enable autoscaling |
| enrichment.autoscaling.maxReplicas | int | `100` | Maximum autoscaling replicas |
| enrichment.autoscaling.minReplicas | int | `1` | Minimum autoscaling replicas |
| enrichment.autoscaling.targetCPUUtilizationPercentage | int | `80` | Target CPU utilisation percentage |
| enrichment.autoscaling.targetMemoryUtilizationPercentage | string | `nil` | Target memory utilisation percentage |
| enrichment.dnsConfig | object | `{}` | DNSConfig settings for pods. |
| enrichment.extraEnv | list | `[]` | Environment variables to add |
| enrichment.extraEnvFrom | list | `[]` | Environment variables from secrets or configmaps to add |
| enrichment.extraPorts | list | `[]` | Port definitions to add |
| enrichment.extraVolumeMounts | list | `[]` | Volume mounts to add |
| enrichment.extraVolumes | list | `[]` | Volumes to add |
| enrichment.hostAliases | list | `[]` | Host aliases to add |
| enrichment.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| enrichment.image.repository | string | `""` | The image repository |
| enrichment.image.tag | string | `""` | The image tag |
| enrichment.imagePullSecrets | list | `[]` | Image pull secrets |
| enrichment.livenessProbe | object | `{}` | Liveness probe settings for pods. |
| enrichment.maxUnavailable | string | `nil` | Pod Disruption Budget maxUnavailable |
| enrichment.nodeSelector | object | `{}` | Tolerations settings for pods. |
| enrichment.podAnnotations | object | `{}` | Annotations for pods |
| enrichment.podLabels | object | `{}` | Labels for pods |
| enrichment.podSecurityContext | object | `{}` | The SecurityContext for pods |
| enrichment.readinessProbe | object | `{}` | Readiness probe settings for pods. |
| enrichment.replicaCount | int | `1` | Number of replicas |
| enrichment.resources | object | `{}` | Resource request & limits. |
| enrichment.roll | bool | `false` | Always roll your deployment |
| enrichment.securityContext | object | `{}` |  |
| enrichment.service.annotations | object | `{}` | Annotations for the service |
| enrichment.service.labels | object | `{}` | Labels for service |
| enrichment.service.port | int | `8080` | Port of the service |
| enrichment.service.type | string | `"ClusterIP"` | Type of the service |
| enrichment.startupProbe | object | `{}` | Startup probe settings for pods. |
| enrichment.tolerations | list | `[]` | Tolerations settings for pods. |
| fullnameOverride | string | `""` | Overrides the chart's computed fullname |
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
| proxy.config | string | see values.yaml | Nginx SSL Reverse Proxy config. The value is templated using `tpl`. |
| proxy.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| proxy.image.repository | string | `"nginx"` | The image repository |
| proxy.image.tag | string | `"1.25-alpine"` | The image tag |
| proxy.resources | object | `{}` | Resource request & limits. |
| proxy.tls.crt | string | `""` | Base64 encoded TLS cert |
| proxy.tls.key | string | `""` | Base64 encoded TLS key |
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

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.12.0](https://github.com/norwoodj/helm-docs/releases/v1.12.0)
