{{/*
default fullname
*/}}
{{- define "backups.postgres.fullname" -}}
{{ include "backups.fullname" . }}
{{- end }}

{{/*
default common labels
*/}}
{{- define "backups.postgres.labels" -}}
{{ include "backups.labels" . }}
{{- end }}

{{/*
default selector labels
*/}}
{{- define "backups.postgres.selectorLabels" -}}
{{ include "backups.selectorLabels" . }}
{{- end }}


{{- define "backups.postgres.pgdumpCommand" -}}
{{- if eq .Values.postgres.type "RDS" -}}
- "/bin/sh"
- "-c"
- "pg_dumpall --no-role-passwords -v --exclude-database=rdsadmin -p {{ .Values.postgres.port }} -h {{ .Values.postgres.host }} -U $PGUSER | gzip > /backup/{{ .Values.postgres.name }}-$(date \"+%Y-%m-%d\").gz"
{{- else if eq .Values.postgres.type "CloudSQL" -}}
- "/bin/sh"
- "-c"
- "pg_dumpall --no-role-passwords -v --exclude-database=cloudsqladmin --exclude-database=template* -p {{ .Values.postgres.port }} -h {{ .Values.postgres.host }} -U $PGUSER | gzip > /backup/{{ .Values.postgres.name }}-$(date \"+%Y-%m-%d\").gz"
#TODO dump command for azure
{{- else if eq .Values.postgres.type "AzurePostgres" -}}
- "/bin/sh"
- "-c"
- "pg_dumpall --no-role-passwords -v --exclude-database=rdsadmin -p {{ .Values.postgres.port }} -h {{ .Values.postgres.host }} -U $PGUSER | gzip > /backup/{{ .Values.postgres.name }}-$(date \"+%Y-%m-%d\").gz"
{{- else if eq .Values.postgres.type "DOPostgres" -}}
- "/bin/sh"
- "-c"
- "pg_dumpall --no-role-passwords -v --exclude-database=_dodb --exclude-database=template* -l defaultdb -p {{ .Values.postgres.port }} -h {{ .Values.postgres.host }} -U $PGUSER | gzip > /backup/{{ .Values.postgres.name }}-$(date \"+%Y-%m-%d\").gz"
#TODO dump command for azure
{{- else if eq .Values.postgres.type "SelfHosted" -}}
- "/bin/sh"
- "-c"
- "pg_dumpall -p {{ .Values.postgres.port }} -h {{ .Values.postgres.host }} -U $PGUSER | gzip > /backup/{{ .Values.postgres.name }}-$(date \"+%Y-%m-%d\").gz"
{{- else }}
{{ fail "Invalid Postgres provider" }}
{{- end -}}
{{- end -}}

{{- define "backups.postgres.uploadCommand" -}}
{{- if eq .Values.upload.type "s3" -}}
{{- if .Values.upload.s3.endpoint -}}
- "/bin/sh"
- "-c"
- "aws s3 cp /backup/{{ .Values.postgres.name }}-$(date \"+%Y-%m-%d\").gz s3://{{ .Values.upload.s3.bucket }}/storage.s3.prefix/{{ .Values.postgres.name }}-$(date \"+%Y-%m-%d\").gz --endpoint={{ .Values.upload.s3.endpoint }}"
{{- else }}
- "/bin/sh"
- "-c"
- "aws s3 cp /backup/{{ .Values.postgres.name }}-$(date \"+%Y-%m-%d\").gz s3://{{ .Values.upload.s3.bucket }}/storage.s3.prefix/{{ .Values.postgres.name }}-$(date \"+%Y-%m-%d\").gz"
{{- end -}}
{{- else if eq .Values.upload.type "gcs" -}}
- "/bin/sh"
- "-c"
- "gcloud storage cp /backup/{{ .Values.postgres.name }}-$(date \"+%Y-%m-%d\").gz gs://{{ .Values.upload.gcp.bucket }}/{{ .Values.upload.gcp.prefix }}/{{ .Values.postgres.name }}-$(date \"+%Y-%m-%d\").gz"
{{- else if eq .Values.upload.type "azure" -}}
- "/bin/sh"
- "-c"
- "az storage file upload --account-name <account-name> --account-key <account-key> --share-name <share-name> --path logo.png --source image.png"
{{- else }}
{{ fail "Invalid storage type" }}
{{- end -}}
{{- end -}}
