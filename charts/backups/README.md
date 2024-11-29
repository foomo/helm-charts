# backups

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

Helm chart for backing things up.

**Homepage:** <https://www.foomo.org>

## Resources

- [Source](https://github.com/foomo/helm-charts)

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| fullnameOverride | string | `""` | Overrides the chart's computed fullname |
| nameOverride | string | `""` | Overrides the chart's name |
| namespaceOverride | string | `""` | The name of the Namespace to deploy If not set, `.Release.Namespace` is used |
| postgres.cronjob.backoffLimit | int | `6` | Set the cronjob parameter backoffLimit |
| postgres.cronjob.concurrencyPolicy | string | `"Forbid"` | Set the cronjob parameter concurrencyPolicy |
| postgres.cronjob.failedJobsHistoryLimit | int | `1` | Set the cronjob parameter failedJobsHistoryLimit |
| postgres.cronjob.restartPolicy | string | `"Never"` | Set the cronjob parameter restartPolicy |
| postgres.cronjob.schedule | string | `"@daily"` | Set the cronjob parameter schedule |
| postgres.cronjob.startingDeadlineSeconds | string | `""` |  |
| postgres.cronjob.successfulJobsHistoryLimit | int | `1` | Set the cronjob parameter successfulJobsHistoryLimit |
| postgres.cronjob.ttlSecondsAfterFinished | string | `""` | Set the cronjob parameter ttlSecondsAfterFinished |
| postgres.dump.extraEnv | list | `[]` | Environment variables to add to pg dump container |
| postgres.dumpImage | string | `"postgres:15-alpine"` |  |
| postgres.enabled | bool | `false` | Enable backup |
| postgres.host | string | `""` | Postgres host |
| postgres.name | string | `"instance-name"` |  |
| postgres.password | string | `""` | Postgres password |
| postgres.port | string | `"5432"` | Postgres port |
| postgres.type | string | `"SelfHosted"` | Set the type of postgres database |
| postgres.upload.extraEnv | list | `[]` | Environment variables to add to save container |
| postgres.user | string | `""` | Postgres user name |
| revisionHistoryLimit | int | `10` | Number of revisions to retain to allow rollback |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.automount | bool | `true` | Automatically mount a ServiceAccount's API credentials? |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | If not set and create is true, a name is generated using the fullname template |
| upload | object | `{}` |  |
