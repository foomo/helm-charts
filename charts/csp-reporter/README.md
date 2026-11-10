# csp-reporter

![Version: 3.0.0](https://img.shields.io/badge/Version-3.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.5.0](https://img.shields.io/badge/AppVersion-1.5.0-informational?style=flat-square)

Content Security Policy Reporter

**Homepage:** <https://www.foomo.org>

## Source Code

* <https://github.com/foomo/helm-charts>

## Upgrading to 3.0.0

The container now runs as uid/gid 65532 with a read-only root filesystem, no capabilities and the
`RuntimeDefault` seccomp profile, and listens on `http.port` (8080) instead of 80. The Service keeps
`service.port` (80) and targets the named port, so clients and ingresses need no change. The chart
always runs `/usr/bin/service --address=:<http.port>` and appends `args`; an address flag in `args`
fails the render. New resource defaults request 10m CPU and 64Mi memory and limit memory to 256Mi.

`helm upgrade --reuse-values` from 2.x keeps the old empty security contexts and resources, so the
pod runs as root on port 8080. To return to root on container port 80, null every new default,
because Helm merges these maps into the chart defaults. The result runs like 2.x but is not
identical: the explicit command and its address flag stay.

```yaml
http:
  port: 80
podSecurityContext:
  runAsUser: null
  runAsGroup: null
  runAsNonRoot: null
  seccompProfile: null
securityContext:
  allowPrivilegeEscalation: null
  readOnlyRootFilesystem: null
  capabilities: null
resources:
  requests: null
  limits: null
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| args | list | `[]` | Extra flags for the reporter binary |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| fullnameOverride | string | `""` |  |
| http.port | int | `8080` | Container port of the report listener, passed to the reporter as its address flag; the Service keeps service.port |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"foomo/csp-reporter"` |  |
| image.tag | string | `"1.5.0"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.tls | list | `[]` |  |
| livenessProbe | object | `{}` | Liveness probe, tcpSocket on the http port when empty; a non-empty value replaces it and must include a handler |
| metrics.port | int | `9200` | Container port of the Prometheus metrics listener; when not 9200, also pass a matching prometheus-address flag in args |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext.runAsGroup | int | `65532` | Run as group id |
| podSecurityContext.runAsNonRoot | bool | `true` | Refuse to start the container as root |
| podSecurityContext.runAsUser | int | `65532` | Run as user id |
| podSecurityContext.seccompProfile | object | `{"type":"RuntimeDefault"}` | Restrict the container's syscalls with seccomp |
| readinessProbe | object | `{}` | Readiness probe, tcpSocket on the http port when empty; a non-empty value replaces it and must include a handler |
| replicaCount | int | `1` |  |
| resources.limits.memory | string | `"256Mi"` | Memory limit |
| resources.requests.cpu | string | `"10m"` | CPU request |
| resources.requests.memory | string | `"64Mi"` | Memory request |
| securityContext.allowPrivilegeEscalation | bool | `false` | Controls whether a process can gain more privileges than its parent process |
| securityContext.capabilities | object | `{"drop":["ALL"]}` | Grant certain privileges to a process without granting all the privileges of the root user |
| securityContext.readOnlyRootFilesystem | bool | `true` | Mounts the container's root filesystem as read-only |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `false` |  |
| serviceAccount.name | string | `""` |  |
| serviceMonitor.additionalLabels | object | `{}` | Additional ServiceMonitor labels, e.g. the label your Prometheus selects on |
| serviceMonitor.enabled | bool | `false` | Create a Prometheus Operator ServiceMonitor and a metrics port on the Service (needs the ServiceMonitor CRD) |
| serviceMonitor.interval | string | `""` | ServiceMonitor scrape interval, Prometheus default when empty |
| tolerations | list | `[]` |  |
