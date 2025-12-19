# sesamy-gtm

![Version: 0.6.0](https://img.shields.io/badge/Version-0.6.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 4.0.0](https://img.shields.io/badge/AppVersion-4.0.0-informational?style=flat-square)

Helm chart for the Sesamy GTM tagging & preview service.

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
| autoscaling.enabled | bool | `false` | Enable autoscaling |
| autoscaling.maxReplicas | int | `9` | Maximum replication number |
| autoscaling.maxUnavailable | int | `1` | Maximum unavailablity |
| autoscaling.minAvailable | string | `""` | Minimum availablity |
| autoscaling.minReplicas | int | `1` | Minimum replication number |
| autoscaling.targetCPU | int | `75` | Target CPU utilization |
| autoscaling.targetMemory | string | `nil` | Target Memory utilization |

### Collect

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| collect.dnsConfig | object | `{}` | DNSConfig settings for pods |
| collect.enabled | bool | `false` | Enable collect |
| collect.extraEnv | list | `[]` | Environment variables to add |
| collect.extraEnvFrom | list | `[]` | Environment variables from secrets or configmaps to add |
| collect.extraPorts | list | `[]` | Port definitions to add |
| collect.extraVolumeMounts | list | `[]` | Volume mounts to add |
| collect.extraVolumes | list | `[]` | Volumes to add |
| collect.hostAliases | list | `[]` | Host aliases to add |
| collect.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| collect.image.recreate | bool | `false` | Force recreation |
| collect.image.repository | string | `""` | The image repository |
| collect.image.tag | string | `""` | The image tag |
| collect.imagePullSecrets | list | `[]` | Image pull secrets |
| collect.livenessProbe | object | `{}` | Liveness probe settings for pods |
| collect.podAnnotations | object | `{}` | Annotations for pods |
| collect.podLabels | object | `{}` | Labels for pods |
| collect.podSecurityContext.fsGroup | int | `1001` | File system group id |
| collect.podSecurityContext.runAsGroup | int | `1001` | Run as group id |
| collect.podSecurityContext.runAsNonRoot | bool | `true` | Indicates wether to run as non root user |
| collect.podSecurityContext.runAsUser | int | `1001` | Run as user id |
| collect.podSecurityContext.seccompProfile | object | `{"type":"RuntimeDefault"}` | Restrict a Container's Syscalls with seccomp |
| collect.readinessProbe | object | `{}` | Readiness probe settings for pods |
| collect.replicaCount | int | `1` | Number of replicas |
| collect.resources | object | `{}` | Resource request & limits |
| collect.securityContext.allowPrivilegeEscalation | bool | `false` | Controls whether a process can gain more privileges than its parent process |
| collect.securityContext.capabilities | object | `{"drop":["ALL"]}` | Grant certain privileges to a process without granting all the privileges of the root user |
| collect.securityContext.readOnlyRootFilesystem | bool | `true` | Mounts the container's root filesystem as read-only |
| collect.service.annotations | object | `{}` | Annotations for the service |
| collect.service.labels | object | `{}` | Labels for service |
| collect.service.ports | object | `{"gtag":8080,"mpv2":8081}` | Ports of the service |
| collect.service.type | string | `"ClusterIP"` | Type of the service |
| collect.startupProbe | object | `{}` | Startup probe settings for pods |

### Deprecated

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

### Google Tag Manager

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| gtm.containerConfig | string | `""` | Base64-encoded container parameters in the URL query string format |
| gtm.containerRefreshSeconds | int | `60` | Interval between container refreshes |
| gtm.googleApplicationCredentials | Optional | `""` | Base64-encoded service account credential that is authorized to access resources |
| gtm.googleCloudProject | Optional | `""` | Google Cloud project ID |
| gtm.image.pullPolicy | string | `"IfNotPresent"` | Image tag |
| gtm.image.repository | string | `"gcr.io/cloud-tagging-10302018/gtm-cloud-image"` | The image repository |
| gtm.image.tag | string | `"4.0.0"` | The image tag of the [release](https://console.cloud.google.com/artifacts/docker/cloud-tagging-10302018/us/gcr.io/gtm-cloud-image?pli=1) |

### Ingress

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ingress.annotations | object | `{}` | Annotations |
| ingress.className | string | `""` | Ingress class name |
| ingress.enabled | bool | `false` | Enable ingress |
| ingress.hosts | list | `[]` | Hosts to listen to |
| ingress.paths | object | `{"preview":[{"path":"/gtm","pathType":"ImplementationSpecific","port":8080}],"tagging":[{"path":"/gtm.js","pathType":"ImplementationSpecific","port":8080},{"path":"/_/set_cookie","pathType":"ImplementationSpecific","port":8080},{"path":"/gtag/js","pathType":"ImplementationSpecific","port":8080},{"path":"/_/service_worker","pathType":"ImplementationSpecific","port":8080},{"path":"/g/collect","pathType":"ImplementationSpecific","port":8080}]}` | Path settings |
| ingress.tls | list | `[]` | Tls setttings |

### Network Policy

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| networkPolicy.discovery.namespaceSelector | object | `{}` | Specifies the namespace the discovery Pods are running in |
| networkPolicy.discovery.podSelector | object | `{}` | Specifies the Pods labels used for discovery |
| networkPolicy.discovery.port | string | `nil` | Specify the port used for discovery |
| networkPolicy.enabled | bool | `false` | Specifies whether Network Policies should be created |
| networkPolicy.externalStorage.cidrs | list | `[]` | Specifies specific network CIDRs you want to limit access to |
| networkPolicy.externalStorage.ports | list | `[]` | Specify the port used for external storage, e.g. AWS S3 |
| networkPolicy.ingress.namespaceSelector | object | `{}` | Specifies the namespaces which are allowed to access the http port |
| networkPolicy.ingress.podSelector | object | `{}` | Specifies the Pods which are allowed to access the http port |
| networkPolicy.metrics.cidrs | list | `[]` | Specifies specific network CIDRs which are allowed to access the metrics port |
| networkPolicy.metrics.namespaceSelector | object | `{}` | Specifies the namespaces which are allowed to access the metrics port |
| networkPolicy.metrics.podSelector | object | `{}` | Specifies the Pods which are allowed to access the metrics port |

### Preview

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| preview.dnsConfig | object | `{}` | DNSConfig settings for pods |
| preview.extraEnv | list | `[]` | Environment variables to add |
| preview.extraEnvFrom | list | `[]` | Environment variables from secrets or configmaps to add |
| preview.extraVolumeMounts | list | `[]` | Volume mounts to add |
| preview.extraVolumes | list | `[]` | Volumes to add |
| preview.hostAliases | list | `[]` | Host aliases to add |
| preview.imagePullSecrets | list | `[]` | Image pull secrets |
| preview.livenessProbe | object | `{"httpGet":{"path":"/healthz","port":"http"}}` | Liveness probe settings for pods |
| preview.podAnnotations | object | `{}` | Annotations for pods |
| preview.podLabels | object | `{}` | Labels for pods |
| preview.podSecurityContext.seccompProfile | object | `{"type":"RuntimeDefault"}` | Restrict a Container's Syscalls with seccomp |
| preview.readinessProbe | object | `{"httpGet":{"path":"/healthz","port":"http"}}` | Readiness probe settings for pods |
| preview.replicaCount | int | `1` | Number of replicas |
| preview.resources | object | `{}` | Resource request & limits |
| preview.securityContext.allowPrivilegeEscalation | bool | `false` | Controls whether a process can gain more privileges than its parent process |
| preview.securityContext.capabilities | object | `{"drop":["ALL"]}` | Grant certain privileges to a process without granting all the privileges of the root user |
| preview.securityContext.readOnlyRootFilesystem | bool | `false` | Mounts the container's root filesystem as read-only |
| preview.service.annotations | object | `{}` | Annotations for the service |
| preview.service.labels | object | `{}` | Labels for service |
| preview.service.port | int | `8080` | Port of the service |
| preview.service.type | string | `"ClusterIP"` | Type of the service |
| preview.startupProbe | object | `{"httpGet":{"path":"/healthz","port":"http"}}` | Startup probe settings for pods |

### HTTPS Proxy

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| proxy.config | string | `"server {\n  listen              443 ssl;\n\n  ssl_certificate     /etc/nginx/ssl/tls.crt;\n  ssl_certificate_key /etc/nginx/ssl/tls.key;\n  ssl_session_cache   shared:SSL:10m;\n  ssl_session_timeout 1h;\n  ssl_buffer_size     8k;\n\n  location / {\n      proxy_pass         http://0.0.0.0:{{ .Values.tagging.service.port }};\n      proxy_set_header   Host $host;\n      proxy_set_header   X-Real-IP $remote_addr;\n      proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;\n      proxy_set_header   X-Forwarded-Host $server_name;\n      proxy_set_header   Upgrade $http_upgrade;\n      proxy_set_header   Connection 'upgrade';\n      proxy_cache_bypass $http_upgrade;\n  }\n}\n"` | Nginx SSL Reverse Proxy config |
| proxy.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| proxy.image.repository | string | `"nginx"` | The image repository |
| proxy.image.tag | string | `"1.29.4-alpine"` | The image [tag](https://hub.docker.com/_/nginx) |
| proxy.resources | object | `{}` | Resource request & limits |
| proxy.securityContext.allowPrivilegeEscalation | bool | `false` | Controls whether a process can gain more privileges than its parent process |
| proxy.securityContext.capabilities | object | `{}` | Grant certain privileges to a process without granting all the privileges of the root user |
| proxy.securityContext.readOnlyRootFilesystem | bool | `false` | Mounts the container's root filesystem as read-only |
| proxy.tls.crt | string | `""` | Base64 encoded TLS cert |
| proxy.tls.key | string | `""` | Base64 encoded TLS key |

### General

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| revisionHistoryLimit | int | `10` | Number of revisions to keep |
| updateStrategy | string | `"RollingUpdate"` | Deployment update strategy |

### Routing

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| routing.enabled | bool | `false` | Indicates wether routing is enabled or not |
| routing.parentRefs | list | `[]` | Parent references |
| routing.paths | object | `{"preview":[{"path":"/gtm","pathType":"PathPrefix","port":8080}],"tagging":[{"path":"/gtm.js","pathType":"Exact","port":8080},{"path":"/_set_cookie","pathType":"Exact","port":8080},{"path":"/gtag/js","pathType":"PathPrefix","port":8080},{"path":"/_/service_worker","pathType":"Prefix","port":8080},{"path":"/g/collect","pathType":"PathPrefix","port":8080}]}` | Path matches |

### Scheduling

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| scheduling.affinity | object | `{"requiredDuringSchedulingIgnoredDuringExecution":{"nodeSelectorTerms":[{"matchExpressions":[{"key":"node-role.kubernetes.io/control-plane","operator":"In","values":[""]}]}]}}` | Affinity for pod assignment |
| scheduling.enabled | bool | `false` | Indicates wether scheduling is enabled or not |
| scheduling.nodeSelector | object | `{}` | Node labels for pod assignment |
| scheduling.priorityClass | string | `nil` | Priority class name |
| scheduling.tolerations | list | `[]` | Tolerations for pod assignment |
| scheduling.topologySpreadConstraints | list | `[{"matchLabelKeys":["pod-template-hash"],"maxSkew":1,"topologyKey":"kubernetes.io/hostname","whenUnsatisfiable":"DoNotSchedule"},{"maxSkew":1,"topologyKey":"topology.kubernetes.io/zone","whenUnsatisfiable":"ScheduleAnyway"}]` | Tolerations for pod assignment |

### Service Account

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.automount | bool | `false` | Automatically mount a ServiceAccount's API credentials? |
| serviceAccount.create | bool | `false` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use |

### Service Monitor

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| serviceMonitor.annotations | object | `{}` | ServiceMonitor annotations |
| serviceMonitor.enabled | bool | `false` | If enabled, ServiceMonitor resources for Prometheus Operator are created |
| serviceMonitor.interval | string | `""` | ServiceMonitor scrape interval |
| serviceMonitor.labels | object | `{}` | Additional ServiceMonitor labels |
| serviceMonitor.metricRelabelings | list | `[]` | ServiceMonitor metric relabel configs to apply to samples before ingestion |
| serviceMonitor.relabelings | list | `[]` | ServiceMonitor relabel configs to apply to samples before scraping |
| serviceMonitor.scrapeTimeout | string | `""` | ServiceMonitor scrape timeout in Go duration format (e.g. 15s) |
| serviceMonitor.targetLabels | list | `[]` | ServiceMonitor will add labels from the service to the Prometheus metric |

### Tagging

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| tagging.dnsConfig | object | `{}` | DNSConfig settings for pods |
| tagging.extraEnv | list | `[]` | Environment variables to add |
| tagging.extraEnvFrom | list | `[]` | Environment variables from secrets or configmaps to add |
| tagging.extraVolumeMounts | list | `[]` | Volume mounts to add |
| tagging.extraVolumes | list | `[]` | Volumes to add |
| tagging.hostAliases | list | `[]` | Host aliases to add |
| tagging.imagePullSecrets | list | `[]` | Image pull secrets |
| tagging.livenessProbe | object | `{"httpGet":{"path":"/healthz","port":"http"}}` | Liveness probe settings for pods |
| tagging.podAnnotations | object | `{}` | Pod annotations |
| tagging.podLabels | object | `{}` | Labels for pods |
| tagging.podSecurityContext.seccompProfile | object | `{"type":"RuntimeDefault"}` | Restrict a Container's Syscalls with seccomp |
| tagging.readinessProbe | object | `{"httpGet":{"path":"/healthz","port":"http"}}` | Readiness probe settings for pods |
| tagging.replicaCount | int | `1` | Number of replicas |
| tagging.resources | object | `{}` | Resource request & limits |
| tagging.securityContext.allowPrivilegeEscalation | bool | `false` | Controls whether a process can gain more privileges than its parent process |
| tagging.securityContext.capabilities | object | `{"drop":["ALL"]}` | Grant certain privileges to a process without granting all the privileges of the root user |
| tagging.securityContext.readOnlyRootFilesystem | bool | `true` | Mounts the container's root filesystem as read-only |
| tagging.service.annotations | object | `{}` | Annotations for the service |
| tagging.service.appProtocol | string | `nil` | Set appProtocol for the service |
| tagging.service.clusterIP | string | `nil` | ClusterIP of the gateway service |
| tagging.service.labels | object | `{}` | Labels for service |
| tagging.service.nodePort | string | `nil` | Node port if service type is NodePort |
| tagging.service.port | int | `8080` | Port of the service |
| tagging.service.type | string | `"ClusterIP"` | Type of the service |
| tagging.startupProbe | object | `{"httpGet":{"path":"/healthz","port":"http"}}` | Liveness probe settings for pods |

