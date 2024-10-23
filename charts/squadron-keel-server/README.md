# squadron-keel-server

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.1](https://img.shields.io/badge/AppVersion-0.1.1-informational?style=flat-square)

Squadron Keel Server chart

**Homepage:** <https://www.foomo.org>

## Source Code

* <https://github.com/foomo/helm-charts>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| autoscaling | object | `{"additionalMetrics":{},"behavior":{},"enabled":false,"maxReplicas":5,"minReplicas":1,"targetCPU":75,"targetMemory":null}` | Autoscaling settings |
| autoscaling.additionalMetrics | object | `{}` | Additional scaling metrics |
| autoscaling.behavior | object | `{}` | Autoscaling behavior settings |
| autoscaling.enabled | bool | `false` | Specifies whether a auto scaling should be enabled |
| autoscaling.maxReplicas | int | `5` | Maximum replication number |
| autoscaling.minReplicas | int | `1` | Minimum replication number |
| autoscaling.targetCPU | int | `75` | Target CPU utilization |
| autoscaling.targetMemory | string | `nil` | Target Memory utilization |
| env | object | `{}` | FOO: bar |
| fleet | string | `""` | Squadron fleet name |
| fullnameOverride | string | `""` | Overrides the chart's computed fullname |
| graceful | object | `{"delaySeconds":15,"enabled":false,"periodSeconds":45}` | Graceful shutdown settings |
| graceful.delaySeconds | int | `15` | Seconds to wait for kubernetes to deregister |
| graceful.enabled | bool | `false` | Indicates wether graceful shutdown is enabled |
| graceful.periodSeconds | int | `45` | Total seconds for the grace period |
| image | object | `{"pullPolicy":"IfNotPresent","pullSecrets":[],"recreate":false,"repository":"","tag":""}` | Image settings |
| image.pullPolicy | string | `"IfNotPresent"` | Image tag |
| image.pullSecrets | list | `[]` | Image pull secrets |
| image.recreate | bool | `false` | Force recreation |
| image.repository | string | `""` | Image repository |
| image.tag | string | `""` | Image tag |
| ingress | object | `{"additionalLabels":{},"annotations":{},"className":"","enabled":false,"hosts":[],"paths":[],"tls":[]}` | Ingress settings |
| ingress.additionalLabels | object | `{}` | Additional labels |
| ingress.annotations | object | `{}` | Ingress annotations |
| ingress.className | string | `""` | Ingress class name |
| ingress.enabled | bool | `false` | Indicates wether the ingress is enabled or not |
| ingress.hosts | list | `[]` | List of hosts |
| ingress.paths | list | `[]` | List of hosts |
| ingress.tls | list | `[]` | TLS settings |
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
| persistence | object | `{"accessMode":"ReadWriteOnce","enabled":false,"mountPath":"/var/data","size":"1Gi","storageClassName":""}` | Persistence settings |
| persistence.accessMode | string | `"ReadWriteOnce"` | Access mode |
| persistence.enabled | bool | `false` | Indicates wether a pv should be attached or not |
| persistence.mountPath | string | `"/var/data"` | Storage mount path |
| persistence.size | string | `"1Gi"` | Storage size |
| persistence.storageClassName | string | `""` | Storage class name |
| podDisruptionBudget | object | `{"enabled":false,"maxUnavailable":"","minAvailable":""}` | See https://kubernetes.io/docs/tasks/run-application/configure-pdb/ |
| podDisruptionBudget.enabled | bool | `false` | Indicates wether the pod disruption budget is enabled |
| ports | object | `{}` | http: 8080 |
| rbac.enabled | bool | `false` | Create PodSecurityPolicy. |
| revisionHistoryLimit | int | `10` | Number of revisions to keep |
| secretEnv | object | `{}` | Map of environment variables to add as a secret |
| secretMounts | list | `[]` |  |
| server | object | `{"additionalEnv":[],"additionalEnvFrom":[],"additionalLabels":{},"additionalPorts":[],"additionalVolumeMounts":[],"additionalVolumes":[],"annotations":{},"hostAliases":[],"livenessProbe":{"httpGet":{"path":"/healthz/liveness","port":"healthz"}},"podAnnotations":{},"readinessProbe":{"httpGet":{"path":"/healthz/readiness","port":"healthz"}},"replicas":1,"resources":{},"startupProbe":{"httpGet":{"path":"/healthz/startup","port":"healthz"}},"strategy":{}}` | Server settings |
| server.additionalEnv | list | `[]` | Additional environment variables |
| server.additionalEnvFrom | list | `[]` | Additional env from |
| server.additionalLabels | object | `{}` | Additional labels |
| server.additionalPorts | list | `[]` | Additional ports |
| server.additionalVolumeMounts | list | `[]` | Additional volume mounts |
| server.additionalVolumes | list | `[]` | Additional volumes |
| server.annotations | object | `{}` | Deployment annotations |
| server.hostAliases | list | `[]` | Host aliases |
| server.livenessProbe | object | `{"httpGet":{"path":"/healthz/liveness","port":"healthz"}}` | See https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes |
| server.podAnnotations | object | `{}` | Pod annotations |
| server.readinessProbe | object | `{"httpGet":{"path":"/healthz/readiness","port":"healthz"}}` | See https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes |
| server.replicas | int | `1` | Number of replications |
| server.resources | object | `{}` | See: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/ |
| server.startupProbe | object | `{"httpGet":{"path":"/healthz/startup","port":"healthz"}}` | See https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes |
| server.strategy | object | `{}` | Deployment strategy settings |
| service | object | `{"additionalLabels":{},"annotations":{},"type":"ClusterIP"}` | Service settings |
| service.additionalLabels | object | `{}` | Additional Service labels |
| service.annotations | object | `{}` | Service annotations |
| service.type | string | `"ClusterIP"` | Service type |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.automount | bool | `true` | Automatically mount a ServiceAccount's API credentials? |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | If not set and create is true, a name is generated using the fullname template |
| serviceMonitor | object | `{"additionalLabels":{},"annotations":{},"enabled":false,"interval":"","metricRelabelings":[],"relabelings":[],"scrapeTimeout":"","targetLabels":[]}` | ServiceMonitor configuration |
| serviceMonitor.additionalLabels | object | `{}` | Additional ServiceMonitor labels |
| serviceMonitor.annotations | object | `{}` | ServiceMonitor annotations |
| serviceMonitor.enabled | bool | `false` | If enabled, ServiceMonitor resources for Prometheus Operator are created |
| serviceMonitor.interval | string | `""` | ServiceMonitor scrape interval |
| serviceMonitor.metricRelabelings | list | `[]` | See https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/api.md#endpoint |
| serviceMonitor.relabelings | list | `[]` | See https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/api.md#relabelconfig |
| serviceMonitor.scrapeTimeout | string | `""` | ServiceMonitor scrape timeout in Go duration format (e.g. 15s) |
| serviceMonitor.targetLabels | list | `[]` | See https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/api.md#servicemonitorspec |
| squadron | string | `""` | Squadron name |
| unit | string | `""` | Squadron unit name |
