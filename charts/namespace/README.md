# namespace

![Version: 0.6.1](https://img.shields.io/badge/Version-0.6.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.6.1](https://img.shields.io/badge/AppVersion-0.6.1-informational?style=flat-square)

Common Namespace Resource Chart

**Homepage:** <https://www.foomo.org>

## Source Code

* <https://github.com/foomo/helm-charts>

## Values

### General

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| clusterRoleBindings | object | `{}` | Role Bindings to create |
| clusterRoles | object | `{}` | Cluster Roles to create |
| clusterSecretStores | object | `{}` | Cluster Secret Stores to create (requires external-secrets.io/v1 CRD) |
| disableSuffix | bool | `false` | Disable suffixes |
| dockerSecrets | object | `{}` | Docker config json secrets |
| externalSecrets | object | `{}` | External Secrets to create (requires external-secrets.io/v1 CRD) |
| resources | object | `{}` | Service accounts settings |
| roleBindings | object | `{}` | Role Bindings to create |
| roles | object | `{}` | Roles to create |
| secrets | object | `{}` | Opaque secrets |
| serviceAccounts | object | `{}` | Service accounts settings |
| tlsSecrets | object | `{}` | TLS secrets |
| volumeClaims | object | `{}` | Service accounts settings |

### Overrides

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| fullnameOverride | string | `""` | Overrides the chart's computed fullname |
| nameOverride | string | `""` | Overrides the chart's name |
| namespaceOverride | string | `""` | The name of the Namespace to deploy |
