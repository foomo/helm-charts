# sesamy-gtm

![Version: 0.0.4](https://img.shields.io/badge/Version-0.0.4-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.3.0](https://img.shields.io/badge/AppVersion-2.3.0-informational?style=flat-square)

Helm chart for the Sesamy GTM tagging & preview service.

**Homepage:** <https://www.foomo.org>

## Resources

- [Source](https://github.com/foomo/helm-charts)
- [GTM Changelog](https://developers.google.com/tag-platform/tag-manager/server-side/release-notes)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://grafana.github.io/helm-charts | loki(loki) | 6.6.1 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| collect.affinity | object | `{}` | Affinity settings for pods. |
| collect.autoscaling.behavior.enabled | bool | `false` | Enable autoscaling behaviours |
| collect.autoscaling.behavior.scaleDown | object | `{}` | Scale down policies, must conform to HPAScalingRules |
| collect.autoscaling.behavior.scaleUp | object | `{}` | Scale up policies, must conform to HPAScalingRules |
| collect.autoscaling.customMetrics | list | `[]` | Custom metrics using the HPA/v2 schema (for example, Pods, Object or External metrics) |
| collect.autoscaling.enabled | bool | `false` | Enable autoscaling |
| collect.autoscaling.maxReplicas | int | `100` | Maximum autoscaling replicas |
| collect.autoscaling.minReplicas | int | `1` | Minimum autoscaling replicas |
| collect.autoscaling.targetCPUUtilizationPercentage | int | `80` | Target CPU utilisation percentage |
| collect.autoscaling.targetMemoryUtilizationPercentage | string | `nil` | Target memory utilisation percentage |
| collect.dnsConfig | object | `{}` | DNSConfig settings for pods. |
| collect.enabled | bool | `false` |  |
| collect.extraEnv | list | `[]` | Environment variables to add |
| collect.extraEnvFrom | list | `[]` | Environment variables from secrets or configmaps to add |
| collect.extraPorts | list | `[]` | Port definitions to add |
| collect.extraVolumeMounts | list | `[]` | Volume mounts to add |
| collect.extraVolumes | list | `[]` | Volumes to add |
| collect.hostAliases | list | `[]` | Host aliases to add |
| collect.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| collect.image.repository | string | `""` | The image repository |
| collect.image.tag | string | `""` | The image tag |
| collect.imagePullSecrets | list | `[]` | Image pull secrets |
| collect.livenessProbe | object | `{}` | Liveness probe settings for pods. |
| collect.maxUnavailable | string | `nil` | Pod Disruption Budget maxUnavailable |
| collect.nodeSelector | object | `{}` | Tolerations settings for pods. |
| collect.podAnnotations | object | `{}` | Annotations for pods |
| collect.podLabels | object | `{}` | Labels for pods |
| collect.podSecurityContext | object | `{}` | The SecurityContext for pods |
| collect.readinessProbe | object | `{}` | Readiness probe settings for pods. |
| collect.replicaCount | int | `1` | Number of replicas |
| collect.resources | object | `{}` | Resource request & limits. |
| collect.roll | bool | `false` | Always roll your deployment |
| collect.securityContext | object | `{}` |  |
| collect.service.annotations | object | `{}` | Annotations for the service |
| collect.service.labels | object | `{}` | Labels for service |
| collect.service.ports | object | `{"ga4":8080,"mpv2":8081}` | Ports of the service |
| collect.service.type | string | `"ClusterIP"` | Type of the service |
| collect.startupProbe | object | `{}` | Startup probe settings for pods. |
| collect.tolerations | list | `[]` | Tolerations settings for pods. |
| fullnameOverride | string | `""` | Overrides the chart's computed fullname |
| gtm.containerConfig | string | `""` | Base64-encoded container parameters in the URL query string format. |
| gtm.containerRefreshSeconds | int | `60` | Interval between container refreshes. |
| gtm.googleApplicationCredentials | Optional | `""` | Base64-encoded service account credential that is authorized to access resources. To use the BigQuery or Firestore API outside of Google Cloud. |
| gtm.googleCloudProject | Optional | `""` | Google Cloud project ID. Let the tagging server implicitly choose the project. |
| gtm.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| gtm.image.repository | string | `"gcr.io/cloud-tagging-10302018/gtm-cloud-image"` | The image repository |
| gtm.image.tag | string | `"2.3.0"` | The image tag |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0] | string | `"example.com"` |  |
| ingress.paths.preview[0].path | string | `"/gtm"` |  |
| ingress.paths.preview[0].pathType | string | `"Prefix"` |  |
| ingress.paths.preview[0].port | int | `8080` |  |
| ingress.paths.tagging[0].path | string | `"/gtm.js"` |  |
| ingress.paths.tagging[0].pathType | string | `"Exact"` |  |
| ingress.paths.tagging[0].port | int | `8080` |  |
| ingress.paths.tagging[1].path | string | `"/gtag/js"` |  |
| ingress.paths.tagging[1].pathType | string | `"Prefix"` |  |
| ingress.paths.tagging[1].port | int | `8080` |  |
| ingress.paths.tagging[2].path | string | `"/g/collect"` |  |
| ingress.paths.tagging[2].pathType | string | `"Prefix"` |  |
| ingress.paths.tagging[2].port | int | `8080` |  |
| ingress.tls | list | `[]` |  |
| loki.backend.replicas | int | `0` |  |
| loki.bloomCompactor.replicas | int | `0` |  |
| loki.bloomGateway.replicas | int | `0` |  |
| loki.compactor.replicas | int | `0` |  |
| loki.deploymentMode | string | `"SingleBinary"` |  |
| loki.distributor.replicas | int | `0` |  |
| loki.enabled | bool | `false` | Enable loki |
| loki.indexGateway.replicas | int | `0` |  |
| loki.ingester.replicas | int | `0` |  |
| loki.loki.auth_enabled | bool | `false` |  |
| loki.loki.commonConfig.replication_factor | int | `1` |  |
| loki.loki.schemaConfig.configs[0].from | string | `"2024-04-01"` |  |
| loki.loki.schemaConfig.configs[0].index.period | string | `"24h"` |  |
| loki.loki.schemaConfig.configs[0].index.prefix | string | `"index_"` |  |
| loki.loki.schemaConfig.configs[0].object_store | string | `"s3"` |  |
| loki.loki.schemaConfig.configs[0].schema | string | `"v13"` |  |
| loki.loki.schemaConfig.configs[0].store | string | `"tsdb"` |  |
| loki.minio.enabled | bool | `true` |  |
| loki.querier.replicas | int | `0` |  |
| loki.queryFrontend.replicas | int | `0` |  |
| loki.queryScheduler.replicas | int | `0` |  |
| loki.read.replicas | int | `0` |  |
| loki.singleBinary.replicas | int | `1` |  |
| loki.write.replicas | int | `0` |  |
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
| preview.affinity | object | `{}` | Affinity settings for pods. |
| preview.autoscaling.behavior.enabled | bool | `false` | Enable autoscaling behaviours |
| preview.autoscaling.behavior.scaleDown | object | `{}` | Scale down policies, must conform to HPAScalingRules |
| preview.autoscaling.behavior.scaleUp | object | `{}` | Scale up policies, must conform to HPAScalingRules |
| preview.autoscaling.customMetrics | list | `[]` | Custom metrics using the HPA/v2 schema (for example, Pods, Object or External metrics) |
| preview.autoscaling.enabled | bool | `false` | Enable autoscaling |
| preview.autoscaling.maxReplicas | int | `100` | Maximum autoscaling replicas |
| preview.autoscaling.minReplicas | int | `1` | Minimum autoscaling replicas |
| preview.autoscaling.targetCPUUtilizationPercentage | int | `80` | Target CPU utilisation percentage |
| preview.autoscaling.targetMemoryUtilizationPercentage | string | `nil` | Target memory utilisation percentage |
| preview.dnsConfig | object | `{}` | DNSConfig settings for pods. |
| preview.extraEnv | list | `[]` | Environment variables to add |
| preview.extraEnvFrom | list | `[]` | Environment variables from secrets or configmaps to add |
| preview.extraVolumeMounts | list | `[]` | Volume mounts to add |
| preview.extraVolumes | list | `[]` | Volumes to add |
| preview.hostAliases | list | `[]` | Host aliases to add |
| preview.imagePullSecrets | list | `[]` | Image pull secrets |
| preview.livenessProbe.httpGet.path | string | `"/healthz"` |  |
| preview.livenessProbe.httpGet.port | string | `"http"` |  |
| preview.maxUnavailable | string | `nil` | Pod Disruption Budget maxUnavailable |
| preview.nodeSelector | object | `{}` | Tolerations settings for pods. |
| preview.podAnnotations | object | `{}` | Annotations for pods |
| preview.podLabels | object | `{}` | Labels for pods |
| preview.podSecurityContext | object | `{}` | The SecurityContext for pods |
| preview.readinessProbe.httpGet.path | string | `"/healthz"` |  |
| preview.readinessProbe.httpGet.port | string | `"http"` |  |
| preview.replicaCount | int | `1` | Number of replicas |
| preview.resources | object | `{}` | Resource request & limits. |
| preview.securityContext | object | `{}` |  |
| preview.service.annotations | object | `{}` | Annotations for the service |
| preview.service.labels | object | `{}` | Labels for service |
| preview.service.port | int | `8080` | Port of the service |
| preview.service.type | string | `"ClusterIP"` | Type of the service |
| preview.tolerations | list | `[]` | Tolerations settings for pods. |
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
| tagging.affinity | object | `{}` | Affinity settings for pods. |
| tagging.autoscaling.behavior.enabled | bool | `false` | Enable autoscaling behaviours |
| tagging.autoscaling.behavior.scaleDown | object | `{}` | Scale down policies, must conform to HPAScalingRules |
| tagging.autoscaling.behavior.scaleUp | object | `{}` | Scale up policies, must conform to HPAScalingRules |
| tagging.autoscaling.customMetrics | list | `[]` | Custom metrics using the HPA/v2 schema (for example, Pods, Object or External metrics) |
| tagging.autoscaling.enabled | bool | `false` | Enable autoscaling |
| tagging.autoscaling.maxReplicas | int | `100` | Maximum autoscaling replicas |
| tagging.autoscaling.minReplicas | int | `1` | Minimum autoscaling replicas |
| tagging.autoscaling.targetCPUUtilizationPercentage | int | `80` | Target CPU utilisation percentage |
| tagging.autoscaling.targetMemoryUtilizationPercentage | string | `nil` | Target memory utilisation percentage |
| tagging.dnsConfig | object | `{}` | DNSConfig settings for pods. |
| tagging.extraEnv | list | `[]` | Environment variables to add |
| tagging.extraEnvFrom | list | `[]` | Environment variables from secrets or configmaps to add |
| tagging.extraVolumeMounts | list | `[]` | Volume mounts to add |
| tagging.extraVolumes | list | `[]` | Volumes to add |
| tagging.hostAliases | list | `[]` | Host aliases to add |
| tagging.imagePullSecrets | list | `[]` | Image pull secrets |
| tagging.livenessProbe.httpGet.path | string | `"/healthz"` |  |
| tagging.livenessProbe.httpGet.port | string | `"http"` |  |
| tagging.maxUnavailable | string | `nil` | Pod Disruption Budget maxUnavailable |
| tagging.nodeSelector | object | `{}` | Tolerations settings for pods. |
| tagging.podAnnotations | object | `{}` | Annotations for pods |
| tagging.podLabels | object | `{}` | Labels for pods |
| tagging.podSecurityContext | object | `{}` | The SecurityContext for pods |
| tagging.readinessProbe.httpGet.path | string | `"/healthz"` |  |
| tagging.readinessProbe.httpGet.port | string | `"http"` |  |
| tagging.replicaCount | int | `1` | Number of replicas |
| tagging.resources | object | `{}` | Resource request & limits. |
| tagging.securityContext | object | `{}` |  |
| tagging.service.annotations | object | `{}` | Annotations for the service |
| tagging.service.appProtocol | string | `nil` | Set appProtocol for the service |
| tagging.service.clusterIP | string | `nil` | ClusterIP of the gateway service |
| tagging.service.labels | object | `{}` | Labels for service |
| tagging.service.nodePort | string | `nil` | Node port if service type is NodePort |
| tagging.service.port | int | `8080` | Port of the service |
| tagging.service.type | string | `"ClusterIP"` | Type of the service |
| tagging.tolerations | list | `[]` | Tolerations settings for pods. |

