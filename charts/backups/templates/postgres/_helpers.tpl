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
{{- if .Values.upload.s3 }}
- "aws s3 cp /backup/{{ .Values.postgres.name }}-$(date \"+%Y-%m-%d\").gz s3://{{ .Values.upload.s3.bucket }}/{{ .Values.postgres.bucketPrefix }}/{{ .Values.postgres.name }}-$(date \"+%Y-%m-%d\").gz {{- if .Values.upload.s3.endpoint }} --endpoint {{ .Values.upload.s3.endpoint }}{{- end }}"
{{- else if .Values.upload.gcp }}
- "gcloud storage cp /backup/{{ .Values.postgres.name }}-$(date \"+%Y-%m-%d\").gz gs://{{ .Values.upload.gcp.bucket }}/{{ .Values.postgres.bucketPrefix }}/{{ .Values.postgres.name }}-$(date \"+%Y-%m-%d\").gz"
{{- else if .Values.upload.azure }}
#TODO upload to azure
- "az storage file upload --account-name <account-name> --account-key <account-key> --share-name <share-name> --path logo.png --source image.png"
{{- else }}
{{ fail "Invalid cloud provider" }}
{{- end -}}
{{- end -}}

{{- define "backups.postgres.cloudImage" -}}
{{- if .Values.upload.s3 -}}
"amazon/aws-cli:2.17.48"
{{- else if .Values.upload.gcp -}}
"google/cloud-sdk:492.0.0"
{{- else if .Values.upload.azure -}}
"mcr.microsoft.com/azure-cli:2.9.1"
{{- else if .Values.upload.do -}}
"amazon/aws-cli:2.17.48"
{{- else }}
{{ fail "Invalid cloud provider: " .Values.cloudProvider }}
{{- end -}}
{{- end -}}
