# squadron-keel-server

![Version: 0.1.7](https://img.shields.io/badge/Version-0.1.7-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.7](https://img.shields.io/badge/AppVersion-0.1.7-informational?style=flat-square)

Squadron Keel Server Chart

**Homepage:** <https://www.foomo.org>

## Source Code

* <https://github.com/foomo/helm-charts>

## Values

### Autoscaling settings

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

### General

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | `{}` | Map of environment variables to add |
| ports | object | `{}` | Map of ports to expose |
| replicas | int | `1` | Number of replications |
| revisionHistoryLimit | int | `10` | Number of revisions to keep |
| secretEnv | object | `{}` | Map of environment variables to add as a secret |
| secretMounts | list | `[]` | List of existing secrets to be mounted |
| secrets | object | `{}` | Map of secrets to be mounted |
| updateStrategy | string | `"RollingUpdate"` | Deployment update strategy |

### Squadron settings

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| fleet | string | `""` | Squadron fleet name |
| squadron | string | `""` | Squadron name |
| unit | string | `""` | Squadron unit name |

### Overrides

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| fullnameOverride | string | `""` | Overrides the chart's computed fullname |
| nameOverride | string | `""` | Overrides the chart's name |
| namespaceOverride | string | `""` | The name of the Namespace to deploy |

### Graceful settings

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| graceful.delaySeconds | int | `15` | Seconds to wait for kubernetes to deregister |
| graceful.enabled | bool | `false` | Indicates wether graceful shutdown is enabled |
| graceful.periodSeconds | int | `45` | Total seconds for the grace period |

### Image settings

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.pullPolicy | string | `"IfNotPresent"` | Image tag |
| image.pullSecrets | list | `[]` | Image pull secrets |
| image.recreate | bool | `false` | Force recreation |
| image.repository | string | `""` | Image repository |
| image.tag | string | `""` | Image tag |

### Ingress settings

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ingress.additionalLabels | object | `{}` | Additional labels |
| ingress.annotations | object | `{}` | Ingress annotations |
| ingress.className | string | `""` | Ingress class name |
| ingress.enabled | bool | `false` | Indicates wether the ingress is enabled or not |
| ingress.hosts | list | `[]` | List of hosts |
| ingress.paths | list | `[]` | List of hosts |
| ingress.tls | list | `[]` | TLS settings |

### Log settings

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| log.level | string | `"info"` | Log level |
| log.mode | string | `"prod"` | Log mode |

### Network Policy settings

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

### OpenTelemetry settings

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| otel.enabled | bool | `false` | Indicates wether to enable it or not |
| otel.gorm.enabled | bool | `true` | Indicates wether to enable it or not |
| otel.gorm.sqlParametersDisabled | bool | `true` | Indicates wether to trace sql attributes |
| otel.gotsrpc.enabled | bool | `true` | Indicates wether to enable it or not |
| otel.gotsrpc.payloadAttributeDisabled | bool | `true` | Indicates wether to trace payload attributes |
| otel.mongo.commandAttributeDisabled | bool | `true` | Indicates wether to trace command attributes |
| otel.mongo.enabled | bool | `true` | Indicates wether to enable it or not |
| otel.otlp | object | `{"endpoint":"alloy:4317","insecure":true}` | OTLP exporter settings |
| otel.otlp.endpoint | string | `"alloy:4317"` | Enpoint uri |
| otel.otlp.insecure | bool | `true` | Indicates wether to use insecure connection |
| otel.ratio | int | `1` | Trace ratio |

### Persistence settings

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| persistence.accessMode | string | `"ReadWriteOnce"` | Access mode |
| persistence.enabled | bool | `false` | Indicates wether a pv should be attached or not |
| persistence.mountPath | string | `"/var/lib/cronjob/data"` | Storage mount path |
| persistence.size | string | `"1Gi"` | Storage size |
| persistence.storageClass | string | `""` | Storage class name |

### RBAC settings

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| rbac.enabled | bool | `false` | Indicates wether scheduling is enabled or not |

### Scheduling settings

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| scheduling.affinity | object | `{}` | Affinity for pod assignment |
| scheduling.enabled | bool | `false` | Indicates wether scheduling is enabled or not |
| scheduling.nodeSelector | object | `{}` | Node labels for pod assignment |
| scheduling.priorityClass | string | `nil` | Priority class name |
| scheduling.tolerations | list | `[]` | Tolerations for pod assignment |

### Security context

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| securityContext.fsGroup | int | `10001` | File system group id |
| securityContext.runAsGroup | int | `10001` | Run as group id |
| securityContext.runAsNonRoot | bool | `true` | Indicates wether to run as non root user |
| securityContext.runAsUser | int | `10001` | Run as user id |

### Server settings

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| server.additionalEnv | list | `[]` | Additional environment variables |
| server.additionalEnvFrom | list | `[]` | Additional env from |
| server.additionalLabels | object | `{}` | Additional labels |
| server.additionalPorts | list | `[]` | Additional ports |
| server.additionalVolumeMounts | list | `[]` | Additional volume mounts |
| server.additionalVolumes | list | `[]` | Additional volumes |
| server.annotations | object | `{}` | Deployment annotations |
| server.hostAliases | list | `[]` | Host aliases |
| server.livenessProbe | object | `{"httpGet":{"path":"/healthz/liveness","port":"healthz"}}` | Liveness probe settings |
| server.podAnnotations | object | `{}` | Pod annotations |
| server.readinessProbe | object | `{"httpGet":{"path":"/healthz/readiness","port":"healthz"}}` | Readiness probe settings |
| server.resources | object | `{}` | Resource settings |
| server.startupProbe | object | `{"httpGet":{"path":"/healthz/startup","port":"healthz"}}` | Startup probe settings |

### Service settings

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.additionalLabels | object | `{}` | Additional Service labels |
| service.annotations | object | `{}` | Service annotations |
| service.type | string | `"ClusterIP"` | Service type |

### Service account settings

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.automount | bool | `true` | Automatically mount a ServiceAccount's API credentials? |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. |

### Service Monitor settings

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
