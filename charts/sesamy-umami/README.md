# sesamy-umami

![Version: 0.0.2](https://img.shields.io/badge/Version-0.0.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.15.1](https://img.shields.io/badge/AppVersion-2.15.1-informational?style=flat-square)

Helm chart for the Sesamy Umami integration.

**Homepage:** <https://www.foomo.org>

## Values

### Overrides

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| fullnameOverride | string | `""` | Overrides the chart's computed fullname |
| nameOverride | string | `""` | Overrides the chart's name |
| namespaceOverride | string | `""` | The name of the Namespace to deploy |

### Ingress

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ingress.annotations | object | `{}` | Annotations |
| ingress.className | string | `""` | Ingress class name |
| ingress.enabled | bool | `false` | Enable ingress |
| ingress.hosts | list | `[]` | Ingress hosts |
| ingress.paths | object | `{"umami":[{"path":"/","pathType":"Prefix","port":8000}]}` | Path settings |
| ingress.tls | list | `[]` | Ingress tls |

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

### Proxy

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| proxy.config | string | `"server {\n  listen              443 ssl;\n\n  ssl_certificate     /etc/nginx/ssl/tls.crt;\n  ssl_certificate_key /etc/nginx/ssl/tls.key;\n  ssl_session_cache   shared:SSL:10m;\n  ssl_session_timeout 1h;\n  ssl_buffer_size     8k;\n\n  location / {\n      proxy_pass         http://0.0.0.0:{{ .Values.umami.service.port }};\n      proxy_set_header   Host $host;\n      proxy_set_header   X-Real-IP $remote_addr;\n      proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;\n      proxy_set_header   X-Forwarded-Host $server_name;\n      proxy_set_header   Upgrade $http_upgrade;\n      proxy_set_header   Connection 'upgrade';\n      proxy_cache_bypass $http_upgrade;\n  }\n}\n"` | Nginx SSL Reverse Proxy config. |
| proxy.image.pullPolicy | string | `"IfNotPresent"` | Image tag |
| proxy.image.repository | string | `"nginx"` | Image repository |
| proxy.image.tag | string | `"1.25-alpine"` | Image tag |
| proxy.resources | object | `{}` | Resource request & limits. |
| proxy.tls.crt | string | `""` | Base64 encoded TLS cert |
| proxy.tls.key | string | `""` | Base64 encoded TLS key |

### General

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| revisionHistoryLimit | int | `10` | Number of revisions to keep |

### Routing

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| routing.enabled | bool | `false` | Indicates wether routing is enabled or not |
| routing.parentRefs | list | `[]` | Parent references |
| routing.paths | list | `[]` | Path matches |

### Service Account

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.automount | bool | `true` | Automatically mount a ServiceAccount's API credentials? |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. |

### Umami

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| umami.affinity | object | `{}` | Affinity settings for pods. |
| umami.autoscaling.behavior.enabled | bool | `false` | Enable autoscaling behaviours |
| umami.autoscaling.behavior.scaleDown | object | `{}` | Scale down policies, must conform to HPAScalingRules |
| umami.autoscaling.behavior.scaleUp | object | `{}` | Scale up policies, must conform to HPAScalingRules |
| umami.autoscaling.customMetrics | list | `[]` | Custom metrics using the HPA/v2 schema |
| umami.autoscaling.enabled | bool | `false` | Enable autoscaling |
| umami.autoscaling.maxReplicas | int | `100` | Maximum autoscaling replicas |
| umami.autoscaling.minReplicas | int | `1` | Minimum autoscaling replicas |
| umami.autoscaling.targetCPUUtilizationPercentage | int | `80` | Target CPU utilisation percentage |
| umami.autoscaling.targetMemoryUtilizationPercentage | string | `nil` | Target memory utilisation percentage |
| umami.config.appSecret.existingSecret | string | `""` | Name of an existing secret containing the app secret under the key app-secret. |
| umami.config.appSecret.existingSecretKey | string | `""` | Key in the existing secret containing the value (default: app-secret) |
| umami.config.appSecret.secret | string | `""` | A random string used to generate unique values. |
| umami.config.clientIpHeader | string | `""` | HTTP header to check for the client's IP address. This is useful when you're behind a proxy that uses non-standard headers. |
| umami.config.cloudMode | string | `"1"` | Disables users, teams, and websites settings page. |
| umami.config.collectApiEndpoint | string | `""` | Allows you to send metrics to a location different than the default `/api/send`. This is to help you avoid some ad-blockers. |
| umami.config.corsMaxAge | string | `"86400"` | How many seconds a CORS preflight should last. Default is 24 hours. |
| umami.config.database.auth.database | string | `""` | Database name |
| umami.config.database.auth.hostname | string | `""` | Database hostname |
| umami.config.database.auth.password | string | `""` | Database password |
| umami.config.database.auth.username | string | `""` | Database username |
| umami.config.database.existingSecret | string | `""` | Use an existing secret containing the database uri. |
| umami.config.database.existingSecretKey | string | `""` | Key in the existing secret containing value (default: database-url) |
| umami.config.database.uri | string | `""` | Full connection string |
| umami.config.disableBotCheck | string | `"1"` | By default bots are excluded from statistics. This disables checking for bots. |
| umami.config.disableLogin | string | `"1"` | Disables the login page for the application |
| umami.config.disableTelemetry | string | `"1"` | Umami collects completely anonymous telemetry data in order help improve the application. You can choose to disable this if you don't want to participate. |
| umami.config.disableUpdates | string | `"1"` | Disables the check for new versions of Umami |
| umami.config.enableTestConsole | string | `"1"` | Enables the internal test page, {host}/console. Admin access is required. Users can manually fire pageviews and events to their websites. |
| umami.config.forceSSL | string | `"1"` | This will redirect all requests from http to https in the Umami application. Note, this does not apply to the tracking script. |
| umami.config.hostname | string | `"0.0.0.0"` | hostname under which Umami will be reached |
| umami.config.ignoreHostname | string | `""` | This will do a DNS lookup on a hostname and the resulting IP address will be ignored. This can be a comma delimited list of hostnames. |
| umami.config.ignoredIpAddresses | string | `""` | You can provide a comma-delimited list of IP address to exclude from data collection. |
| umami.config.logQuery | string | `"1"` | If you are running in development mode, this will log database queries to the console for debugging. |
| umami.config.removeDisableLoginEnv | bool | `true` | setting this to true removes the environment variable DISABLE_LOGIN defined in `umami.disableLogin` from the deployment as this caused errors in some setups |
| umami.config.removeTrailingSlash | string | `"1"` | Removes the trailing slash from all incoming urls. |
| umami.config.trackerScriptName | string | `"umami"` | Allows you to assign a custom name to the tracker script different from the default umami. This is to help you avoid some ad-blockers. |
| umami.dnsConfig | object | `{}` | DNSConfig settings for pods. |
| umami.extraEnv | list | `[]` | Environment variables to add |
| umami.extraEnvFrom | list | `[]` | Environment variables from secrets or configmaps to add |
| umami.extraPorts | list | `[]` | Port definitions to add |
| umami.extraVolumeMounts | list | `[]` | Volume mounts to add |
| umami.extraVolumes | list | `[]` | Volumes to add |
| umami.hostAliases | list | `[]` | Host aliases to add |
| umami.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| umami.image.registry | string | `"ghcr.io"` | The image registry |
| umami.image.repository | string | `"umami-software/umami"` | The image repository |
| umami.image.tag | string | `"postgresql-v2.15.1"` | The image tag |
| umami.imagePullSecrets | list | `[]` | Image pull secrets |
| umami.livenessProbe | object | `{"httpGet":{"path":"/","port":"http"}}` | Liveness probe settings for pods. |
| umami.maxUnavailable | string | `nil` | Pod Disruption Budget maxUnavailable |
| umami.nodeSelector | object | `{}` | Tolerations settings for pods. |
| umami.podAnnotations | object | `{}` | Annotations for pods |
| umami.podLabels | object | `{}` | Labels for pods |
| umami.podSecurityContext | object | `{}` | The SecurityContext for pods |
| umami.readinessProbe | object | `{"httpGet":{"path":"/","port":"http"}}` | Readiness probe settings for pods. |
| umami.replicaCount | int | `1` | Number of replicas |
| umami.resources | object | `{}` | Resource request & limits. |
| umami.securityContext | object | `{}` | Security context |
| umami.service.annotations | object | `{}` | Annotations for the service |
| umami.service.labels | object | `{}` | Labels for service |
| umami.service.port | int | `8000` | Port of the service |
| umami.service.type | string | `"ClusterIP"` | Type of the service |
| umami.startupProbe | object | `{}` | Startup probe settings for pods. |
| umami.tolerations | list | `[]` | Tolerations settings for pods. |

### Other Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| rbac.enabled | bool | `false` | Create PodSecurityPolicy. |

