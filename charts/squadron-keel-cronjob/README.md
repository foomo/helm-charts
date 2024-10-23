# squadron-keel-cronjob

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

Squadron Keel CronJob Chart

**Homepage:** <https://www.foomo.org>

## Source Code

* <https://github.com/foomo/helm-charts>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cronjob | object | `{"additionalEnv":[],"additionalEnvFrom":[],"additionalLabels":{},"additionalVolumeMounts":[],"additionalVolumes":[],"annotations":{},"backoffLimit":0,"concurrency":"Forbid","historyLimit":1,"hostAliases":[],"jobAnnotations":{},"jobLabels":{},"livenessProbe":{"httpGet":{"path":"/healthz/liveness","port":"healthz"}},"podAnnotations":{},"readinessProbe":{"httpGet":{"path":"/healthz/readiness","port":"healthz"}},"resources":{},"restart":"Never","startupProbe":{"httpGet":{"path":"/healthz/startup","port":"healthz"}}}` | CronJob settings |
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
| env | object | `{}` | FOO: bar |
| fleet | string | `""` | Squadron fleet name |
| fullnameOverride | string | `""` | Overrides the chart's computed fullname |
| graceful | object | `{"delaySeconds":15,"enabled":false,"periodSeconds":45}` | Graceful shutdown settings |
| graceful.delaySeconds | int | `15` | Seconds to wait for kubernetes to deregister |
| graceful.enabled | bool | `false` | Indicates wether graceful shutdown is enabled |
| graceful.periodSeconds | int | `45` | Total seconds for the grace period |
| image | object | `{"pullPolicy":"IfNotPresent","pullSecrets":[],"repository":"","tag":""}` | Image settings |
| image.pullPolicy | string | `"IfNotPresent"` | Image tag |
| image.pullSecrets | list | `[]` | Image pull secrets |
| image.repository | string | `""` | Image repository |
| image.tag | string | `""` | Image tag |
| log | object | `{"level":"info","mode":"prod"}` | Log settings |
| log.level | string | `"info"` | Log level |
| log.mode | string | `"prod"` | Log mode |
| nameOverride | string | `""` | Overrides the chart's name |
| namespaceOverride | string | `""` | If not set, `.Release.Namespace` is used |
| networkPolicy.egress | object | `{"additionalRules":[],"allowExternal":true,"enabled":true}` | Egress settings |
| networkPolicy.egress.additionalRules | list | `[]` | Additional egress rules |
| networkPolicy.egress.allowExternal | bool | `true` | Allow ingress through labels |
| networkPolicy.egress.enabled | bool | `true` | Specifies whether egress should be enabled |
| networkPolicy.enabled | bool | `false` | Specifies whether Network Policies should be created |
| networkPolicy.ingress | object | `{"additionalRules":[],"allowExternal":true,"enabled":true}` | Ingress settings |
| networkPolicy.ingress.additionalRules | list | `[]` | Additional ingress rules |
| networkPolicy.ingress.allowExternal | bool | `true` | Allow ingress through labels |
| networkPolicy.ingress.enabled | bool | `true` | Specifies whether ingress should be enabled |
| networkPolicy.rules | list | `[]` |  |
| otel | object | `{"enabled":false,"gorm":{"enabled":true,"sqlParametersDisabled":true},"gotsrpc":{"enabled":true,"payloadAttributeDisabled":true},"mongo":{"commandAttributeDisabled":true,"enabled":true},"otlp":{"endpoint":"alloy:4317","insecure":true},"ratio":1}` | OpenTelemetry settings |
| otel.enabled | bool | `false` | Indicates wether to enable it or not |
| otel.gorm | object | `{"enabled":true,"sqlParametersDisabled":true}` | GORM settings |
| otel.gorm.sqlParametersDisabled | bool | `true` | Indicates wether to trace sql attributes |
| otel.gotsrpc | object | `{"enabled":true,"payloadAttributeDisabled":true}` | GOTSRPC settings |
| otel.gotsrpc.enabled | bool | `true` | Indicates wether to enable it or not |
| otel.gotsrpc.payloadAttributeDisabled | bool | `true` | Indicates wether to trace payload attributes |
| otel.mongo | object | `{"commandAttributeDisabled":true,"enabled":true}` | Mongo settings |
| otel.mongo.commandAttributeDisabled | bool | `true` | Indicates wether to trace command attributes |
| otel.mongo.enabled | bool | `true` | Indicates wether to enable it or not |
| otel.otlp | object | `{"endpoint":"alloy:4317","insecure":true}` | OTLP exporter settings |
| otel.otlp.endpoint | string | `"alloy:4317"` | Enpoint uri |
| otel.otlp.insecure | bool | `true` | Indicates wether to use insecure connection |
| otel.ratio | int | `1` | Trace ratio |
| persistence | object | `{"accessMode":"ReadWriteOnce","enabled":false,"mountPath":"/var/lib/cronjob/data","size":"1Gi","storageClass":""}` | Persistence settings |
| persistence.accessMode | string | `"ReadWriteOnce"` | Access mode |
| persistence.enabled | bool | `false` | Indicates wether a pv should be attached or not |
| persistence.mountPath | string | `"/var/lib/cronjob/data"` | Storage mount path |
| persistence.size | string | `"1Gi"` | Storage size |
| persistence.storageClass | string | `""` | Storage class name |
| rbac | object | `{"enabled":false}` | RBAC configuration |
| rbac.enabled | bool | `false` | Create PodSecurityPolicy. |
| revisionHistoryLimit | int | `10` | Number of revisions to keep |
| schedule | string | `""` | Cron job schedule |
| scheduling | object | `{"affinity":{},"enabled":false,"nodeSelector":{},"priorityClass":null,"tolerations":[]}` | Scheduling settings |
| scheduling.affinity | object | `{}` | Affinity for pod assignment |
| scheduling.enabled | bool | `false` | Indicates wether scheduling is enabled or not |
| scheduling.nodeSelector | object | `{}` | Node labels for pod assignment |
| scheduling.tolerations | list | `[]` | Tolerations for pod assignment |
| secretEnv | object | `{}` | Map of environment variables to add as a secret |
| secretMounts | list | `[]` |  |
| securityContext | object | `{"fsGroup":10001,"runAsGroup":10001,"runAsNonRoot":true,"runAsUser":10001}` | Security context |
| securityContext.fsGroup | int | `10001` | File system group id |
| securityContext.runAsGroup | int | `10001` | Run as group id |
| securityContext.runAsNonRoot | bool | `true` | Indicates wether to run as non root user |
| securityContext.runAsUser | int | `10001` | Run as user id |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.automount | bool | `true` | Automatically mount a ServiceAccount's API credentials? |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | If not set and create is true, a name is generated using the fullname template |
| squadron | string | `""` | Squadron name |
| timeZone | string | `"Europe/Berlin"` | Cron job time zone |
| unit | string | `""` | Squadron unit name |
