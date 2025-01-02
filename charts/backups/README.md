# backups

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

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
| cronjob.restart | string | `"Never"` | Set the cronjob parameter restart |
| cronjob.schedule | string | `"@daily"` | Set the cronjob parameter schedule |
| cronjob.startingDeadlineSeconds | int | `0` | Set the cronjob parameter startingDeadlineSeconds |
| cronjob.successfulJobsHistoryLimit | int | `1` | Set the cronjob parameter successfulJobsHistoryLimit |
| cronjob.ttlSecondsAfterFinished | int | `0` | Set the cronjob parameter ttlSecondsAfterFinished |

### Overrides

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| fullnameOverride | string | `""` | Overrides the chart's computed fullname |
| nameOverride | string | `""` | Overrides the chart's name |
| namespaceOverride | string | `""` | The name of the Namespace to deploy |

### Postgres

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| postgres.dump.extraEnv | list | `[]` | Environment variables to add to pg dump container |
| postgres.enabled | bool | `false` | Enable backup |
| postgres.host | string | `""` | Postgres host |
| postgres.image | string | `"postgres:15-alpine"` | Postgres image |
| postgres.name | string | `"instance-name"` | Postgres instance name |
| postgres.password | string | `""` | Postgres password |
| postgres.port | string | `"5432"` | Postgres port |
| postgres.type | string | `"SelfHosted"` | Set the type of postgres database |
| postgres.upload.extraEnv | list | `[]` | Environment variables to add to save container |
| postgres.user | string | `""` | Postgres user name |

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
| upload.gcs.bucket | string | `""` | Bucket name |
| upload.gcs.image | string | `"google/cloud-sdk:504.0.1"` | Upload image name https://hub.docker.com/r/google/cloud-sdk/tags |
| upload.gcs.prefix | string | `""` | Bucket prefix |
| upload.s3.accessKey | string | `""` | Bucket access key |
| upload.s3.bucket | string | `""` | Bucket name |
| upload.s3.endpoint | string | `""` | Bucket endpoint |
| upload.s3.image | string | `"amazon/aws-cli:2.22.26"` | Upload image name https://hub.docker.com/r/amazon/aws-cli/tags |
| upload.s3.prefix | string | `""` | Bucket prefix |
| upload.s3.secretAccessKey | string | `""` | Bucket secret access key |
| upload.type | string | `"s3"` | Storage type |
