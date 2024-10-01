# namespace

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.1](https://img.shields.io/badge/AppVersion-0.1.1-informational?style=flat-square)

Common Namespace Resource Chart

**Homepage:** <https://www.foomo.org>

## Source Code

* <https://github.com/foomo/helm-charts>

## Values

### Overrides

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| fullnameOverride | string | `""` | Overrides the chart's computed fullname |
| nameOverride | string | `""` | Overrides the chart's name |
| namespaceOverride | string | `""` | The name of the Namespace to deploy If not set, `.Release.Namespace` is used |

### Other Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| secrets | object | `{"dockerConfigs":{},"opaque":{},"tls":{}}` | Namspace secrets |
| secrets.dockerConfigs | object | `{}` | Docker config json secrets |
| secrets.opaque | object | `{}` | Opaque secrets |
| secrets.tls | object | `{}` | TLS secrets |
| serviceAccounts | object | `{}` | Namspace serviceaccounts |
