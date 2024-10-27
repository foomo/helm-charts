# squadron-keel-cronjob

![Version: 0.1.5](https://img.shields.io/badge/Version-0.1.5-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.5](https://img.shields.io/badge/AppVersion-0.1.5-informational?style=flat-square)

Squadron Keel CronJob Chart

**Homepage:** <https://www.foomo.org>

## Source Code

* <https://github.com/foomo/helm-charts>

## Values

### CronJob settings

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cronjob.additionalEnv | list | `[]` | Additional environment variables |
| cronjob.additionalEnvFrom | list | `[]` | Additional env from |
| cronjob.additionalLabels | object | `{}` | Additional labels |
| cronjob.additionalVolumeMounts | list | `[]` | Additional volume mounts |
| cronjob.additionalVolumes | list | `[]` | Additional volumes |
| cronjob.annotations | object | `{}` | Deployment annotations |
| cronjob.backoffLimit | int | `0` | Successful history item to keep |
| cronjob.concurrency | string | `"Forbid"` | Concurency policy |
| cronjob.historyLimit | int | `1` | Max history item to keep |
| cronjob.hostAliases | list | `[]` | Host aliases |
| cronjob.jobAnnotations | object | `{}` | Pod annotations |
| cronjob.jobLabels | object | `{}` | Job labels |
| cronjob.livenessProbe | object | `{"httpGet":{"path":"/healthz/liveness","port":"healthz"}}` | Liveness probe settings |
| cronjob.podAnnotations | object | `{}` | Pod annotations |
| cronjob.readinessProbe | object | `{"httpGet":{"path":"/healthz/readiness","port":"healthz"}}` | Readiness probe settings |
| cronjob.resources | object | `{}` | Resource settings |
| cronjob.restart | string | `"Never"` | Restart policy |
| cronjob.startupProbe | object | `{"httpGet":{"path":"/healthz/startup","port":"healthz"}}` | Startup probe settings |

### General

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | `{}` | Map of environment variables to add |
| revisionHistoryLimit | int | `10` | Number of revisions to keep |
| schedule | string | `""` | Cron job schedule |
| secretEnv | object | `{}` | Map of environment variables to add as a secret |
| secretMounts | list | `[]` | List of existing secrets to be mounted |
| secrets | object | `{}` | Map of secrets to be mounted |
| timeZone | string | `"Europe/Berlin"` | Cron job time zone |

### Overrides

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| fullnameOverride | string | `""` | Overrides the chart's computed fullname |
| nameOverride | string | `""` | Overrides the chart's name |
| namespaceOverride | string | `""` | The name of the Namespace to deploy |

### Global

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.foomo.squadron.fleet | string | `""` | Will be automatically injected (optional) |
| global.foomo.squadron.name | string | `""` | Will be automatically injected |
| global.foomo.squadron.unit | string | `""` | Will be automatically injected |

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
| image.repository | string | `""` | Image repository |
| image.tag | string | `""` | Image tag |

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

### ServiceAccount settings

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.automount | bool | `true` | Automatically mount a ServiceAccount's API credentials? |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. |

### Other Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.foomo.withDeprecatedSelectorLabels | bool | `false` |  |
