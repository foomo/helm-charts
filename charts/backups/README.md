# backups

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.1](https://img.shields.io/badge/AppVersion-0.1.1-informational?style=flat-square)

Helm chart for backing things up.

**Homepage:** <https://www.foomo.org>

## Resources

- [Source](https://github.com/foomo/helm-charts)

## Values

### Cronjob

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cronjob.backoffLimit | int | `6` | Set the cronjob parameter backoffLimit |
| cronjob.concurrency | string | `"Forbid"` | Set the cronjob parameter concurrency |
| cronjob.failedJobsHistoryLimit | int | `1` | Set the cronjob parameter failedJobsHistoryLimit |
| cronjob.podAnnotations | object | `{}` | Pod annotations |
| cronjob.podLabels | object | `{}` | Pod labels |
| cronjob.restart | string | `"Never"` | Set the cronjob parameter restart |
| cronjob.schedule | string | `"@daily"` | Set the cronjob parameter schedule |
| cronjob.startingDeadlineSeconds | int | `0` | Set the cronjob parameter startingDeadlineSeconds |
| cronjob.successfulJobsHistoryLimit | int | `1` | Set the cronjob parameter successfulJobsHistoryLimit |
| cronjob.ttlSecondsAfterFinished | int | `0` | Set the cronjob parameter ttlSecondsAfterFinished |

### Contentful

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| dump.contentful.image | string | `"foomo/contentful-cli:v3.8.5"` | Contentful image |
| dump.contentful.password | string | `""` | Contentful password |
| dump.contentful.spaceId | string | `""` | Contentful space id |

### Dump

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| dump.dump.extraEnv | list | `[]` | Environment variables to add to pg dump container |
| dump.pullPolicy | string | `"IfNotPresent"` | Image tag |
| dump.type | string | `"postgres"` | Storage type |
| dump.upload.extraEnv | list | `[]` | Environment variables to add to save container |

### Postgres

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| dump.postgres.host | string | `""` | Postgres host |
| dump.postgres.image | string | `""` | Postgres image |
| dump.postgres.name | string | `"instance-name"` | Postgres instance name |
| dump.postgres.password | string | `""` | Postgres password |
| dump.postgres.port | string | `"5432"` | Postgres port |
| dump.postgres.type | string | `"SelfHosted"` | Set the type of postgres database |
| dump.postgres.user | string | `""` | Postgres user name |

### Overrides

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| fullnameOverride | string | `""` | Overrides the chart's computed fullname |
| nameOverride | string | `""` | Overrides the chart's name |
| namespaceOverride | string | `""` | The name of the Namespace to deploy |

### General

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| revisionHistoryLimit | int | `10` | Number of revisions to keep |

### Service Account

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.automount | bool | `true` | Automatically mount a ServiceAccount's API credentials? |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. |

### Upload

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| upload.azure.containerName | string | `""` | Container name |
| upload.azure.image | string | `"mcr.microsoft.com/azure-cli:2.71.0"` | Upload image name https://hub.docker.com/r/microsoft/azure-cli |
| upload.azure.prefix | string | `""` | Bucket prefix |
| upload.azure.storageAccount | string | `""` | Storage Account name |
| upload.gcs.bucket | string | `""` | Bucket name |
| upload.gcs.image | string | `"google/cloud-sdk:519.0.0"` | Upload image name https://hub.docker.com/r/google/cloud-sdk/tags |
| upload.gcs.prefix | string | `""` | Bucket prefix |
| upload.pullPolicy | string | `"IfNotPresent"` | Image tag |
| upload.s3.accessKey | string | `""` | Bucket access key |
| upload.s3.bucket | string | `""` | Bucket name |
| upload.s3.endpoint | string | `""` | Bucket endpoint |
| upload.s3.image | string | `"amazon/aws-cli:2.27.2"` | Upload image name https://hub.docker.com/r/amazon/aws-cli/tags |
| upload.s3.prefix | string | `""` | Bucket prefix |
| upload.s3.secretAccessKey | string | `""` | Bucket secret access key |
| upload.type | string | `"s3"` | Storage type |
