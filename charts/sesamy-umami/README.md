# sesamy-umami

![Version: 0.0.2](https://img.shields.io/badge/Version-0.0.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.11.3](https://img.shields.io/badge/AppVersion-2.11.3-informational?style=flat-square)

Helm chart for the Sesamy Umami integration.

**Homepage:** <https://www.foomo.org>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| fullnameOverride | string | `""` | Overrides the chart's computed fullname |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` | Ingress class name |
| ingress.enabled | bool | `false` | Enable ingress |
| ingress.hosts[0] | string | `"example.com"` |  |
| ingress.paths.umami[0].path | string | `"/"` |  |
| ingress.paths.umami[0].pathType | string | `"Prefix"` |  |
| ingress.paths.umami[0].port | int | `8000` |  |
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
| umami.affinity | object | `{}` | Affinity settings for pods. |
| umami.autoscaling.behavior.enabled | bool | `false` | Enable autoscaling behaviours |
| umami.autoscaling.behavior.scaleDown | object | `{}` | Scale down policies, must conform to HPAScalingRules |
| umami.autoscaling.behavior.scaleUp | object | `{}` | Scale up policies, must conform to HPAScalingRules |
| umami.autoscaling.customMetrics | list | `[]` | Custom metrics using the HPA/v2 schema (for example, Pods, Object or External metrics) |
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
| umami.image.tag | string | `"postgresql-v2.11.3"` | The image tag |
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
| umami.securityContext | object | `{}` |  |
| umami.service.annotations | object | `{}` | Annotations for the service |
| umami.service.labels | object | `{}` | Labels for service |
| umami.service.port | int | `8000` | Port of the service |
| umami.service.type | string | `"ClusterIP"` | Type of the service |
| umami.startupProbe | object | `{}` | Startup probe settings for pods. |
| umami.tolerations | list | `[]` | Tolerations settings for pods. |

