# namespace

![Version: 0.2.2](https://img.shields.io/badge/Version-0.2.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.2.2](https://img.shields.io/badge/AppVersion-0.2.2-informational?style=flat-square)

Common Namespace Resource Chart

**Homepage:** <https://www.foomo.org>

## Source Code

* <https://github.com/foomo/helm-charts>

## Values

### General

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| dockerSecrets | object | `{}` | Docker config json secrets |
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