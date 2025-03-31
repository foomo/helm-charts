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
- "/bin/sh"
- "-c"
{{- if eq .Values.postgres.type "RDS" }}
- "pg_dumpall --no-role-passwords -v --exclude-database=rdsadmin {{ with .Values.postgres.port }} -p {{ . }} {{- end }} {{ with .Values.postgres.host }} -h {{ . }} {{- end }} -U $PGUSER | gzip > /backup/{{ .Values.postgres.name }}-$(date \"+%Y-%m-%d\").gz"
{{- else if eq .Values.postgres.type "CloudSQL" }}
- "pg_dumpall --no-role-passwords -v --exclude-database=cloudsqladmin --exclude-database=template* {{ with .Values.postgres.port }} -p {{ . }} {{- end }} {{ with .Values.postgres.host }} -h {{ . }} {{- end }} -U $PGUSER | gzip > /backup/{{ .Values.postgres.name }}-$(date \"+%Y-%m-%d\").gz"
{{- else if eq .Values.postgres.type "AzurePostgres" }}
#TODO dump command for azure
- "pg_dumpall --no-role-passwords -v --exclude-database=rdsadmin {{ with .Values.postgres.port }} -p {{ . }} {{- end }} {{ with .Values.postgres.host }} -h {{ . }} {{- end }} -U $PGUSER | gzip > /backup/{{ .Values.postgres.name }}-$(date \"+%Y-%m-%d\").gz"
{{- else if eq .Values.postgres.type "DOPostgres" }}
- "pg_dumpall --no-role-passwords -v --exclude-database=_dodb --exclude-database=template* -l defaultdb {{ with .Values.postgres.port }} -p {{ . }} {{- end }} {{ with .Values.postgres.host }} -h {{ . }} {{- end }} -U $PGUSER | gzip > /backup/{{ .Values.postgres.name }}-$(date \"+%Y-%m-%d\").gz"
{{- else if eq .Values.postgres.type "SelfHosted" }}
#TODO dump command for selfhosted
- "pg_dumpall {{ with .Values.postgres.port }} -p {{ . }} {{- end }} {{ with .Values.postgres.host }} -h {{ . }} {{- end }} -U $PGUSER | gzip > /backup/{{ .Values.postgres.name }}-$(date \"+%Y-%m-%d\").gz"
{{- else }}
{{ fail "Invalid Postgres provider" }}
{{- end -}}
{{- end -}}

{{- define "backups.postgres.uploadCommand" -}}
- "/bin/sh"
- "-c"
{{- if eq .Values.upload.type "s3" -}}
- "aws s3 cp /backup/{{ .Values.postgres.name }}-$(date \"+%Y-%m-%d\").gz s3://{{ .Values.upload.s3.bucket }}/{{ .Values.upload.s3.prefix }}/{{ .Values.postgres.name }}-$(date \"+%Y-%m-%d\").gz {{- if .Values.upload.s3.endpoint }} --endpoint {{ .Values.upload.s3.endpoint }}{{- end }}"
{{- else if eq .Values.upload.type "gcs" -}}
- "gcloud storage cp /backup/{{ .Values.postgres.name }}-$(date \"+%Y-%m-%d\").gz gs://{{ .Values.upload.gcs.bucket }}/{{ .Values.upload.gcs.prefix }}/{{ .Values.postgres.name }}-$(date \"+%Y-%m-%d\").gz"
{{- else if eq .Values.upload.type "azure" -}}
- "az storage file upload --account-name <account-name> --account-key <account-key> --share-name <share-name> --path logo.png --source image.png"
{{- else }}
{{ fail "Invalid storage type" }}
{{- end -}}
{{- end -}}
