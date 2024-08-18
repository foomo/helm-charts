# beam

![Version: 0.2.0](https://img.shields.io/badge/Version-0.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.2.0](https://img.shields.io/badge/AppVersion-0.2.0-informational?style=flat-square)

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
| oci://registry-1.docker.io/bitnamicharts | pinniped(pinniped) | 2.2.15 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cloudflared.account | string | `""` |  |
| cloudflared.affinity | object | `{}` | Affinity settings for pods. |
| cloudflared.autoscaling.behavior.enabled | bool | `false` | Enable autoscaling behaviours |
| cloudflared.autoscaling.behavior.scaleDown | object | `{}` | Scale down policies, must conform to HPAScalingRules |
| cloudflared.autoscaling.behavior.scaleUp | object | `{}` | Scale up policies, must conform to HPAScalingRules |
| cloudflared.autoscaling.customMetrics | list | `[]` | Custom metrics using the HPA/v2 schema (for example, Pods, Object or External metrics) |
| cloudflared.autoscaling.enabled | bool | `false` | Enable autoscaling |
| cloudflared.autoscaling.maxReplicas | int | `9` | Maximum autoscaling replicas |
| cloudflared.autoscaling.minReplicas | int | `1` | Minimum autoscaling replicas |
| cloudflared.autoscaling.targetCPUUtilizationPercentage | int | `80` | Target CPU utilisation percentage |
| cloudflared.autoscaling.targetMemoryUtilizationPercentage | string | `nil` | Target memory utilisation percentage |
| cloudflared.dnsConfig | object | `{}` | DNSConfig settings for pods. |
| cloudflared.enableWarp | bool | `false` |  |
| cloudflared.enabled | bool | `false` |  |
| cloudflared.extraEnv | list | `[]` | Environment variables to add |
| cloudflared.extraEnvFrom | list | `[]` | Environment variables from secrets or configmaps to add |
| cloudflared.extraVolumeMounts | list | `[]` | Volume mounts to add |
| cloudflared.extraVolumes | list | `[]` | Volumes to add |
| cloudflared.hostAliases | list | `[]` | Host aliases to add |
| cloudflared.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| cloudflared.image.repository | string | `"cloudflare/cloudflared"` | The image repository |
| cloudflared.image.tag | string | `"2024.8.2"` | The image tag |
| cloudflared.imagePullSecrets | list | `[]` | Image pull secrets |
| cloudflared.ingress | list | `[]` |  |
| cloudflared.livenessProbe.failureThreshold | int | `1` |  |
| cloudflared.livenessProbe.httpGet.path | string | `"/ready"` |  |
| cloudflared.livenessProbe.httpGet.port | int | `2000` |  |
| cloudflared.livenessProbe.initialDelaySeconds | int | `10` |  |
| cloudflared.livenessProbe.periodSeconds | int | `10` |  |
| cloudflared.maxUnavailable | string | `nil` | Pod Disruption Budget maxUnavailable |
| cloudflared.nodeSelector | object | `{}` | Tolerations settings for pods. |
| cloudflared.podAnnotations | object | `{}` | Annotations for pods |
| cloudflared.podLabels | object | `{}` | Labels for pods |
| cloudflared.podSecurityContext | object | `{}` | The SecurityContext for pods Security items common to everything in the pod.  Here we require that it does not run as the user defined in the image, literally named "nonroot". |
| cloudflared.readinessProbe.httpGet.path | string | `"/ready"` |  |
| cloudflared.readinessProbe.httpGet.port | int | `2000` |  |
| cloudflared.replicaCount | int | `2` | Number of replicas |
| cloudflared.resources | object | `{}` | Resource request & limits. |
| cloudflared.secret | string | `""` |  |
| cloudflared.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| cloudflared.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| cloudflared.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| cloudflared.tolerations | list | `[]` | Tolerations settings for pods. |
| cloudflared.tunnelId | string | `""` |  |
| cloudflared.tunnelName | string | `""` |  |
| cloudflaredSidecars | list | `[]` | - Additional cloudflared sidecars |
| cloudflaredSplitter.beams | object | `{}` | - List of additional enpoints beams:   kubectl: your-cloud-provider-k8s-api |
| cloudflaredSplitter.enabled | bool | `false` | - Enable cloudflared splitter |
| cloudflaredSplitter.extraEnv | list | `[]` | Environment variables to add |
| cloudflaredSplitter.extraEnvFrom | list | `[]` | Environment variables from secrets or configmaps to add |
| cloudflaredSplitter.extraVolumeMounts | list | `[]` | Volume mounts to add |
| cloudflaredSplitter.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| cloudflaredSplitter.image.repository | string | `"nginx"` | The image repository |
| cloudflaredSplitter.image.tag | string | `"1.27.0"` | The image tag |
| cloudflaredSplitter.livenessProbe | object | `{}` |  |
| cloudflaredSplitter.readinessProbe | object | `{}` |  |
| cloudflaredSplitter.resources | object | `{}` | Resource request & limits. |
| cloudflaredSplitter.securityContext | object | `{}` | - Security context |
| fullnameOverride | string | `""` | Overrides the chart's computed fullname |
| nameOverride | string | `""` | Overrides the chart's name |
| namespaceOverride | string | `""` | The name of the Namespace to deploy If not set, `.Release.Namespace` is used |
| pinniped.concierge.credentialIssuerConfig | string | `"impersonationProxy:\n  mode: enabled\n  service:\n    type: ClusterIP\n  externalEndpoint: {{ .Release.Name }}-pinniped-concierge-impersonation-proxy-cluster-ip.{{ .Release.Namespace }}:443\n"` |  |
| pinniped.concierge.enabled | bool | `false` | - Enable concierge |
| pinniped.concierge.jwtAuths | object | `{}` | - JWT Authenticators for Concierge jwtAuths:   your-org:     issuer: https://beam.your-domain.com/issuer-path     audience: arbitrary-but-unique-audience |
| pinniped.concierge.teams | object | `{}` | - ClusterRoleBinding to create in the cluster teams:   dev:     role: editor     team: organization/team-dev   devops:     role: cluster-admin     team: organization/team-devops |
| pinniped.enabled | bool | `false` | - Enable pinniped |
| pinniped.supervisor.enabled | bool | `false` | - Enable supervisor |
| pinniped.supervisor.federationDomains | object | `{}` | - Federation Domains to create in the supervisor cluster federationDomains:   cluster:     tlsSecretName: tls-secret-name     issuer: https://beam.your-domain.com/issuer-path     identityProviders:       foomo:         teams:           - organization/team-devs           - organization/team-devops |
| pinniped.supervisor.githubProviders | object | `{}` | - GitHub Providers to create in the supervisor cluster githubProviders:   foomo:     clientId: id     clientSecret: secret |
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

