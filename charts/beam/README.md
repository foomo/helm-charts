# beam

![Version: 0.4.0](https://img.shields.io/badge/Version-0.4.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.4.0](https://img.shields.io/badge/AppVersion-0.4.0-informational?style=flat-square)

Secure infrastructure access

## Usage

### Supervisor

- Create a GitHub app
- Configure your GitHub teams and members
- Add the following to your `values.yaml`

```yaml
pinniped:
  enabled: true
  supervisor:
    enabled: true
    githubProviders:
      provider-name:
        organization: <YOUR_GITHUB_ORG>
        clientId: <GITHUB_APP_CLIENT_ID>
        clientSecret: <GITHUB_APP_CLIENT_SECRET>
    federationDomains:
      domain-name:
        issuer: https://beam.your-domain.com/issuer-path
        tlsSecretName: <TLS_SECRET_NAME>
        identityProviders:
          provider-name:
            teams:
              - organization/your-dev-team
              - organization/your-devops-team
```

- Wait for the supervisor to acquire a loadbalancer ip
- Add a Cloudflare DNS record to point to the supervisor loadbalancer ip

### Cloudflared & Concierge

- Create a new Cloudflare Network Tunnel and retrive it's token:

```shell
$ cloudflared tunnel create <TUNNEL_NAME>
$ cloudflared tunnel token <TUNNEL_NAME>
```

- Add the following to your `values.yaml`

```yaml
cloudflared:
  enabled: true
  token: <TUNNEL_TOKEN>

cloudflaredSplitter:
  enabled: true
  beams:
		# lets you issue pinniped get kubeconfig with validation
    kubectl: <PROVIDER_KUBECTL_ENDPOINT>

cloudflaredSidecars:
  - name: digitalocean
    image: "digitalocean/doctl:latest"
    imagePullPolicy: IfNotPresent
    env:
      - name: DIGITALOCEAN_ACCESS_TOKEN
        value: <YOUR-DO-API-TOKEN>

pinniped:
  enabled: true
  concierge:
    enabled: true
    teams:
      dev:
        role: editor
        team: organization/your-dev-team
      devops:
        role: cluster-admin
        team: organization/your-devops-team
    jwtAuths:
      domain-name:
        issuer: https://beam.your-domain.com/issuer-path
        audience: arbitrary-but-unique-audience
```

### Kubernetes access

- Start cloudflare tunnel on local machine:

```shell
$ cloudflared access tcp --hostname beam.your-domain.com --url 127.0.0.1:1234
```

- Retrieve a kubeconfig using the original kubeconfig, through the tunnel:

```shell
HTTPS_PROXY=socks5://127.0.0.1:1234 pinniped get kubeconfig --kubeconfig "path/to/provider/kubeconfig.yaml" > beam-kubeconfig.yaml
```

- Connect to the cluster:

```shell
HTTPS_PROXY=socks5://127.0.0.1:1234 kubectl get namespaces --kubeconfig "beam-kubeconfig.yaml"
```

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| oci://registry-1.docker.io/bitnamicharts | pinniped(pinniped) | 2.3.3 |

## Values

### Cloudflared settings

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cloudflared.account | string | `""` | Your Cloudflare account number. |
| cloudflared.autoscaling.additionalMetrics | object | `{}` | Additional scaling metrics |
| cloudflared.autoscaling.behavior | object | `{}` | Autoscaling behavior settings |
| cloudflared.autoscaling.enabled | bool | `false` | Specifies whether a auto scaling should be enabled |
| cloudflared.autoscaling.maxReplicas | int | `9` | Maximum replication number |
| cloudflared.autoscaling.maxUnavailable | int | `1` | Maximum unavailablity |
| cloudflared.autoscaling.minAvailable | string | `""` | Minimum availablity |
| cloudflared.autoscaling.minReplicas | int | `1` | Minimum replication number |
| cloudflared.autoscaling.targetCPU | int | `80` | Target CPU utilization |
| cloudflared.autoscaling.targetMemory | string | `nil` | Target Memory utilization |
| cloudflared.dnsConfig | object | `{}` | DNS config |
| cloudflared.enableWarp | bool | `false` | If true, turn on WARP routing for TCP |
| cloudflared.enabled | bool | `false` | Indicates wether to enable it or not |
| cloudflared.extraEnv | list | `[]` | Environment variables to add |
| cloudflared.extraEnvFrom | list | `[]` | Environment variables from secrets or configmaps to add |
| cloudflared.extraVolumeMounts | list | `[]` | Volume mounts to add |
| cloudflared.extraVolumes | list | `[]` | Volumes to add |
| cloudflared.hostAliases | list | `[]` | Host aliases to add |
| cloudflared.image.pullPolicy | string | `"IfNotPresent"` | Image tag |
| cloudflared.image.pullSecrets | list | `[]` | Image pull secrets |
| cloudflared.image.repository | string | `"cloudflare/cloudflared"` | Image repository |
| cloudflared.image.tag | string | `"2024.10.1"` | Image tag |
| cloudflared.ingress | list | `[]` | Define ingress rules for the tunnel ([read more](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/configuration/configuration-file/ingress)) |
| cloudflared.livenessProbe | object | `{"failureThreshold":1,"httpGet":{"path":"/ready","port":2000},"initialDelaySeconds":10,"periodSeconds":10}` | Liveness probe settings for pods. |
| cloudflared.podAnnotations | object | `{}` | Annotations for pods |
| cloudflared.podLabels | object | `{}` | Labels for pods |
| cloudflared.podMonitor.additionalLabels | object | `{}` | Additional ServiceMonitor labels |
| cloudflared.podMonitor.annotations | object | `{}` | ServiceMonitor annotations |
| cloudflared.podMonitor.enabled | bool | `false` | If enabled, ServiceMonitor resources for Prometheus Operator are created |
| cloudflared.podMonitor.interval | string | `""` | ServiceMonitor scrape interval |
| cloudflared.podMonitor.metricRelabelings | list | `[]` | ServiceMonitor metric relabel configs to apply to samples before ingestion |
| cloudflared.podMonitor.relabelings | list | `[]` | ServiceMonitor relabel configs to apply to samples before scraping. |
| cloudflared.podMonitor.scrapeTimeout | string | `""` | ServiceMonitor scrape timeout in Go duration format (e.g. 15s) |
| cloudflared.podMonitor.targetLabels | list | `[]` | ServiceMonitor will add labels from the service to the Prometheus metric |
| cloudflared.podSecurityContext | object | `{}` | The SecurityContext for pods |
| cloudflared.readinessProbe | object | `{"httpGet":{"path":"/ready","port":2000}}` | Readiness probe settings for pods. |
| cloudflared.replicas | int | `2` | Number of replications |
| cloudflared.resources | object | `{}` | Resource request & limits. |
| cloudflared.scheduling.affinity | object | `{}` | Affinity for pod assignment |
| cloudflared.scheduling.enabled | bool | `true` | Indicates wether scheduling is enabled or not |
| cloudflared.scheduling.nodeSelector | object | `{}` | Node labels for pod assignment |
| cloudflared.scheduling.priorityClass | string | `nil` | Priority class name |
| cloudflared.scheduling.tolerations | list | `[]` | Tolerations for pod assignment |
| cloudflared.secret | string | `""` | The secret for the tunnel. |
| cloudflared.securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":true}` | Security items for one container. We lock it down. |
| cloudflared.startupProbe | object | `{"httpGet":{"path":"/ready","port":2000}}` | Readiness probe settings for pods. |
| cloudflared.tunnelId | string | `""` | The ID of the above tunnel. |
| cloudflared.tunnelName | string | `""` | The name of the tunnel this instance will serve |

### Cloudflared Sidecars settings

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cloudflaredSidecars | list | `[]` | Additional cloudflared sidecars |

### Cloudflared Splitter settings

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cloudflaredSplitter.beams | object | `{}` | Mao of additional enpoints |
| cloudflaredSplitter.enabled | bool | `false` | Enable cloudflared splitter |
| cloudflaredSplitter.extraEnv | list | `[]` | Environment variables to add |
| cloudflaredSplitter.extraEnvFrom | list | `[]` | Environment variables from secrets or configmaps to add |
| cloudflaredSplitter.extraVolumeMounts | list | `[]` | Volume mounts to add |
| cloudflaredSplitter.image.pullPolicy | string | `"IfNotPresent"` | Image tag |
| cloudflaredSplitter.image.repository | string | `"nginx"` | Image repository |
| cloudflaredSplitter.image.tag | string | `"1.27.2"` | Image tag |
| cloudflaredSplitter.livenessProbe | object | `{}` | Liveness probe settings for pods |
| cloudflaredSplitter.readinessProbe | object | `{}` | Readiness probe settings for pods |
| cloudflaredSplitter.resources | object | `{}` | Resource request & limits. |
| cloudflaredSplitter.securityContext | object | `{}` | Security context |
| cloudflaredSplitter.startProbe | object | `{}` | Startup probe settings for pods |

### Overrides

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| fullnameOverride | string | `""` | Overrides the chart's computed fullname |
| nameOverride | string | `""` | Overrides the chart's name |
| namespaceOverride | string | `""` | The name of the Namespace to deploy |

### Pinniped settings

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| pinniped.concierge.credentialIssuerConfig | string | `"impersonationProxy:\n  mode: enabled\n  service:\n    type: ClusterIP\n  externalEndpoint: {{ .Release.Name }}-pinniped-concierge-impersonation-proxy-cluster-ip.{{ .Release.Namespace }}:443\n"` | Override dependency |
| pinniped.concierge.enabled | bool | `false` | Enable concierge |
| pinniped.concierge.jwtAuths | object | `{}` | JWT Authenticators for Concierge |
| pinniped.concierge.teams | object | `{}` | ClusterRoleBinding to create in the cluster |
| pinniped.enabled | bool | `false` | Enable pinniped |
| pinniped.supervisor.enabled | bool | `false` | Enable supervisor |
| pinniped.supervisor.federationDomains | object | `{}` | Federation Domains to create in the supervisor cluster |
| pinniped.supervisor.githubProviders | object | `{}` | GitHub Providers to create in the supervisor cluster |

### General

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| revisionHistoryLimit | int | `10` | Number of revisions to keep |

### Service account settings

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.automount | bool | `true` | Automatically mount a ServiceAccount's API credentials? |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. |

