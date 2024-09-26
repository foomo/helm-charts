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
| postgres.cronjob.concurrencyPolicy | string | `"Forbid"` |  |
| postgres.cronjob.failedJobsHistoryLimit | int | `1` |  |
| postgres.cronjob.restartPolicy | string | `"Never"` |  |
| postgres.cronjob.schedule | string | `"@daily"` | Set the cronjob parameter schedule |
| postgres.cronjob.startingDeadlineSeconds | string | `""` |  |
| postgres.cronjob.successfulJobsHistoryLimit | int | `1` |  |
| postgres.cronjob.ttlSecondsAfterFinished | string | `""` |  |
| postgres.dump.extraEnv | list | `[]` | Environment variables to add to pg dump container |
| postgres.enabled | bool | `false` |  |
| postgres.host | string | `"postgres-host"` |  |
| postgres.name | string | `"instance-name"` |  |
| postgres.password | string | `"password"` |  |
| postgres.port | string | `"5432"` |  |
| postgres.postgresVersion | string | `"15"` |  |
| postgres.save.extraEnv | list | `[]` | Environment variables to add to save container |
| postgres.storage | string | `nil` | Set the storage location for the postgres dump, S3, GCS, Azure bucket |
| postgres.type | string | `"SelfHosted"` | Set the type of postgres database |
| postgres.user | string | `"postgres"` |  |
| revisionHistoryLimit | int | `10` | Number of revisions to retain to allow rollback |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.automount | bool | `true` | Automatically mount a ServiceAccount's API credentials? |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `"system-backups"` | If not set and create is true, a name is generated using the fullname template |
