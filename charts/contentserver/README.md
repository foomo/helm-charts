# contentserver

![Version: 0.5.0](https://img.shields.io/badge/Version-0.5.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.12.0](https://img.shields.io/badge/AppVersion-1.12.0-informational?style=flat-square)

Helm chart for the foomo Content Server.

**Homepage:** <https://www.foomo.org>

## Resources

- [Source](https://github.com/foomo/helm-charts)
- [GTM Changelog](https://developers.google.com/tag-platform/tag-manager/server-side/release-notes)

## Values

### Autoscaling

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| autoscaling.additionalMetrics | object | `{}` | Additional scaling metrics |
| autoscaling.behavior | object | `{}` | Autoscaling behavior settings |
| autoscaling.enabled | bool | `false` | Specifies whether a auto scaling should be enabled |
| autoscaling.maxReplicas | int | `9` | Maximum replication number |
| autoscaling.maxUnavailable | int | `1` | Maximum unavailablity |
| autoscaling.minAvailable | string | `""` | Minimum availablity |
| autoscaling.minReplicas | int | `1` | Minimum replication number |
| autoscaling.targetCPU | int | `75` | Target CPU utilization |
| autoscaling.targetMemory | string | `nil` | Target Memory utilization |

### Content Server

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| contentserver.basePath | string | `"/contentserver"` | Path to export the webserver on |
| contentserver.extraArgs | list | `[]` | Arguements to add |
| contentserver.extraEnv | list | `[]` | Environment variables to add |
| contentserver.extraEnvFrom | list | `[]` | Environment variables from secrets or configmaps to add |
| contentserver.extraPorts | list | `[]` | Port definitions to add |
| contentserver.extraVolumeMounts | list | `[]` | Volume mounts to add |
| contentserver.extraVolumes | list | `[]` | Volumes to add |
| contentserver.hostAliases | list | `[]` | Host aliases |
| contentserver.image.pullPolicy | string | `"IfNotPresent"` | Image tag |
| contentserver.image.repository | string | `"foomo/contentserver"` | Image repository |
| contentserver.image.tag | string | `"1.12.0"` | Image tag |
| contentserver.imagePullSecrets | list | `[]` | Image pull secrets |
| contentserver.livenessProbe | object | `{"httpGet":{"path":"/healthz/liveness","port":9400}}` | Liveness probe settings for pods |
| contentserver.podAnnotations | object | `{}` | Annotations for pods |
| contentserver.podLabels | object | `{}` | Labels for pods |
| contentserver.readinessProbe | object | `{"httpGet":{"path":"/healthz/readiness","port":9400}}` | Readiness probe settings for pods |
| contentserver.repository.poll | bool | `false` | If true, the address arg will be used to periodically poll the content url e.g. http://contentserverexport:8080/poll-revision |
| contentserver.repository.pollInterval | string | `"60s"` | Update poll interval |
| contentserver.repository.url | string | `"http://contentserverexport:8080"` | Repository server url |
| contentserver.resources | object | `{}` | Resource request & limits |
| contentserver.securityContext | object | `{}` | Security Context |
| contentserver.startupProbe | object | `{"httpGet":{"path":"/healthz/startup","port":9400}}` | Startup probe settings for pods |

### Overrides

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| fullnameOverride | string | `""` | Overrides the chart's computed fullname |
| nameOverride | string | `""` | Overrides the chart's name |
| namespaceOverride | string | `""` | The name of the Namespace to deploy |

### Graceful Shutdown

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| graceful.delaySeconds | int | `15` | Seconds to wait for kubernetes to deregister |
| graceful.enabled | bool | `false` | Indicates wether graceful shutdown is enabled |
| graceful.periodSeconds | int | `45` | Total seconds for the grace period |

### Ingress

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ingress.additionalLabels | object | `{}` | Additional labels |
| ingress.annotations | object | `{}` | Ingress annotations |
| ingress.className | string | `""` | Ingress class name |
| ingress.enabled | bool | `false` | Indicates wether the ingress is enabled or not |
| ingress.hosts | list | `[]` | List of hosts |
| ingress.paths | list | `[]` | List of hosts |
| ingress.tls | list | `[]` | TLS settings |

### Logging

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| log.level | string | `"info"` | Log level |
| log.mode | string | `"prod"` | Log mode |

### Network Policy

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| networkPolicy.egress.additionalRules | list | `[]` | Additional egress rules |
| networkPolicy.egress.allowExternal | bool | `true` | Allow ingress through labels |
| networkPolicy.egress.enabled | bool | `true` | Specifies whether egress should be enabled |
| networkPolicy.enabled | bool | `false` | Specifies whether Network Policies should be created |
| networkPolicy.ingress.additionalRules | list | `[]` | Additional ingress rules |
| networkPolicy.ingress.allowExternal | bool | `true` | Allow ingress through labels |
| networkPolicy.ingress.enabled | bool | `true` | Specifies whether ingress should be enabled |
| networkPolicy.rules | list | `[]` | List of rules to apply via labels |

### OpenTelemetry

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| otel.enabled | bool | `false` | Indicates wether to enable it or not |
| otel.otlp | object | `{"endpoint":"alloy:4317","insecure":true}` | OTLP exporter settings |
| otel.otlp.endpoint | string | `"alloy:4317"` | Enpoint uri |
| otel.otlp.insecure | bool | `true` | Indicates wether to use insecure connection |
| otel.ratio | int | `1` | Trace ratio |

### Persistence

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| persistence.accessModes | list | `["ReadWriteOnce"]` | Access modes for the PVC |
| persistence.annotations | object | `{}` | Annotations for the PVC |
| persistence.enabled | bool | `false` | Enable persistent storage |
| persistence.labels | object | `{}` | Labels for the PVC |
| persistence.path | string | `"/var/lib/contentserver"` | File storage location |
| persistence.size | string | `"1Gi"` | Storage size |
| persistence.storageClass | string | `""` | Storage class to be used |

### RBAC

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| rbac.enabled | bool | `false` | Create PodSecurityPolicy |

### General

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| replicas | int | `1` | Number of replications |
| revisionHistoryLimit | int | `10` | Number of revisions to keep |
| updateStrategy | string | `"RollingUpdate"` | Deployment update strategy |

### Routing

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| routing.enabled | bool | `false` | Indicates wether routing is enabled or not |
| routing.parentRefs | list | `[]` | Parent references |
| routing.paths | list | `[]` | Path matches |

### Scheduling

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| scheduling.affinity | object | `{"requiredDuringSchedulingIgnoredDuringExecution":{"nodeSelectorTerms":[{"matchExpressions":[{"key":"node-role.kubernetes.io/control-plane","operator":"In","values":[""]}]}]}}` | Affinity for pod assignment |
| scheduling.enabled | bool | `false` | Indicates wether scheduling is enabled or not |
| scheduling.nodeSelector | object | `{}` | Node labels for pod assignment |
| scheduling.priorityClass | string | `nil` | Priority class name |
| scheduling.tolerations | list | `[]` | Tolerations for pod assignment |
| scheduling.topologySpreadConstraints | list | `[{"matchLabelKeys":["pod-template-hash"],"maxSkew":1,"topologyKey":"kubernetes.io/hostname","whenUnsatisfiable":"DoNotSchedule"},{"maxSkew":1,"topologyKey":"topology.kubernetes.io/zone","whenUnsatisfiable":"ScheduleAnyway"}]` | Tolerations for pod assignment |

### Security Context

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| securityContext.fsGroup | int | `1001` | File system group id |
| securityContext.runAsGroup | int | `1001` | Run as group id |
| securityContext.runAsNonRoot | bool | `true` | Indicates wether to run as non root user |
| securityContext.runAsUser | int | `1001` | Run as user id |

### Service

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.additionalLabels | object | `{}` | Additional Service labels |
| service.annotations | object | `{}` | Service annotations |
| service.type | string | `"ClusterIP"` | Service type |

### Service Account

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.automount | bool | `true` | Automatically mount a ServiceAccount's API credentials? |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. |

### Service Monitor

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| serviceMonitor.additionalLabels | object | `{}` | Additional ServiceMonitor labels |
| serviceMonitor.annotations | object | `{}` | ServiceMonitor annotations |
| serviceMonitor.enabled | bool | `false` | If enabled, ServiceMonitor resources for Prometheus Operator are created |
| serviceMonitor.interval | string | `""` | ServiceMonitor scrape interval |
| serviceMonitor.metricRelabelings | list | `[]` | ServiceMonitor metric relabel configs to apply to samples before ingestion |
| serviceMonitor.relabelings | list | `[]` | ServiceMonitor relabel configs to apply to samples before scraping. |
| serviceMonitor.scrapeTimeout | string | `""` | ServiceMonitor scrape timeout in Go duration format (e.g. 15s) |
| serviceMonitor.targetLabels | list | `[]` | ServiceMonitor will add labels from the service to the Prometheus metric |
