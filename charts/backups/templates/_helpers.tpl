{{/*
Expand the name of the chart.
*/}}
{{- define "backups.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "backups.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "backups.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "backups.labels" -}}
helm.sh/chart: {{ include "backups.chart" . }}
{{ include "backups.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "backups.selectorLabels" -}}
app.kubernetes.io/name: {{ .Release.Name }}
{{- end }}

{{/*
Networking labels
*/}}
{{- define "backups.cronjob.networkingLabels" -}}
{{- if .Values.networkPolicy.enabled }}
{{- range .Values.networkPolicy.rules }}
networking/{{ . }}: "true"
{{- end}}
{{- if .Values.networkPolicy.ingress.enabled }}
{{- if .Values.networkPolicy.ingress.allowExternal }}
kubernetes.io/networking.name: {{ include "backups.fullname" . }}
{{- end}}
{{- end}}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "backups.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "backups.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the namespace
*/}}
{{- define "backups.namespace" -}}
{{- default .Release.Namespace .Values.namespaceOverride }}
{{- end }}

{{/*
Retrieve upload image
*/}}
{{- define "backups.upload.image" -}}
{{- if eq .Values.upload.type "s3" -}}
{{ .Values.upload.s3.image }}
{{- else if eq .Values.upload.type "gcs" -}}
{{ .Values.upload.gcs.image }}
{{- else if eq .Values.upload.type "azure" -}}
{{ .Values.upload.azure.image }}
{{- else if eq .Values.upload.type "do" -}}
{{ .Values.upload.do.image }}
{{- else }}
{{ fail "Invalid storage type" }}
{{- end -}}
{{- end -}}

{{/*
Retrieve dump image
*/}}
{{- define "backups.dump.image" -}}
{{- if eq .Values.dump.type "contentful" -}}
{{ .Values.dump.contentful.image }}
{{- else if eq .Values.dump.type "postgres" -}}
{{ .Values.dump.postgres.image }}
{{- else }}
{{ fail "Invalid dump type" }}
{{- end -}}
{{- end -}}

{{- define "backups.dump.secrets" -}}
{{- if eq .Values.dump.type "contentful" -}}
TOKEN: {{ .Values.dump.contentful.password }}
SPACE_ID: {{ .Values.dump.contentful.spaceId }}
{{- else if eq .Values.dump.type "postgres" -}}
PGUSER: {{ .Values.dump.postgres.user }}
PGPASSWORD: {{ .Values.dump.postgres.password }}
PGENDPOINT: {{ .Values.dump.postgres.host }}
PGPORT: {{ .Values.dump.postgres.port }}
{{- else }}
{{ fail "Invalid dump type" }}
{{- end -}}
{{- end -}}

{{- define "backups.upload.secrets" -}}
{{- if eq .Values.upload.type "s3" -}}
{{- else if eq .Values.upload.type "gcs" -}}
{{- else if eq .Values.upload.type "azure" -}}
{{- else if eq .Values.upload.type "do" -}}
{{- else }}
{{ fail "Invalid storage type" }}
{{- end -}}
{{- end -}}

{{- define "backups.dump.dumpCommand" -}}
{{- if eq .Values.dump.type "contentful" }}
- "/bin/sh"
- "-c"
- "/usr/local/bin/contentful space export --use-verbose-renderer --management-token=\"$TOKEN\" --space-id=\"$SPACE_ID\" --export-dir=/backup --max-allowed-limit=100 --download-assets"
{{- else if eq .Values.dump.type "postgres" }}
- "/bin/sh"
- "-c"
{{- if eq .Values.dump.postgres.type "RDS" }}
- "pg_dumpall --no-role-passwords -v --exclude-database=rdsadmin {{ with .Values.dump.postgres.port }} -p {{ . }} {{- end }} {{ with .Values.dump.postgres.host }} -h {{ . }} {{- end }} -U $PGUSER | gzip > /backup/{{ .Values.dump.postgres.name }}-$(date \"+%Y-%m-%d\").gz"
{{- else if eq .Values.dump.postgres.type "CloudSQL" }}
- "pg_dumpall --no-role-passwords -v --exclude-database=cloudsqladmin --exclude-database=template* {{ with .Values.dump.postgres.port }} -p {{ . }} {{- end }} {{ with .Values.dump.postgres.host }} -h {{ . }} {{- end }} -U $PGUSER | gzip > /backup/{{ .Values.dump.postgres.name }}-$(date \"+%Y-%m-%d\").gz"
{{- else if eq .Values.dump.postgres.type "AzurePostgres" }}
#TODO dump command for azure
- "pg_dumpall --no-role-passwords -v --exclude-database=rdsadmin {{ with .Values.dump.postgres.port }} -p {{ . }} {{- end }} {{ with .Values.dump.postgres.host }} -h {{ . }} {{- end }} -U $PGUSER | gzip > /backup/{{ .Values.dump.postgres.name }}-$(date \"+%Y-%m-%d\").gz"
{{- else if eq .Values.dump.postgres.type "DOPostgres" }}
- "pg_dumpall --no-role-passwords -v --exclude-database=_dodb --exclude-database=template* -l defaultdb {{ with .Values.postgres.port }} -p {{ . }} {{- end }} {{ with .Values.dump.postgres.host }} -h {{ . }} {{- end }} -U $PGUSER | gzip > /backup/{{ .Values.dump.postgres.name }}-$(date \"+%Y-%m-%d\").gz"
{{- else if eq .Values.dump.postgres.type "SelfHosted" }}
#TODO dump command for selfhosted
- "pg_dumpall {{ with .Values.dump.postgres.port }} -p {{ . }} {{- end }} {{ with .Values.dump.postgres.host }} -h {{ . }} {{- end }} -U $PGUSER | gzip > /backup/{{ .Values.dump.postgres.name }}-$(date \"+%Y-%m-%d\").gz"
{{- else }}
{{ fail "Invalid Postgres provider" }}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "backups.dump.uploadCommand" -}}
- "/bin/sh"
- "-c"
{{ if eq .Values.upload.type "s3" -}}
- "aws s3 cp /backup/{{ .Values.dump.postgres.name }}-$(date \"+%Y-%m-%d\").gz s3://{{ .Values.upload.s3.bucket }}/{{ .Values.upload.s3.prefix }}/{{ .Values.dump.postgres.name }}-$(date \"+%Y-%m-%d\").gz {{- if .Values.upload.s3.endpoint }} --endpoint {{ .Values.upload.s3.endpoint }}{{- end }}"
{{ else if eq .Values.upload.type "gcs" -}}
- "gcloud storage cp /backup/{{ .Values.dump.postgres.name }}-$(date \"+%Y-%m-%d\").gz gs://{{ .Values.upload.gcs.bucket }}/{{ .Values.upload.gcs.prefix }}/{{ .Values.dump.postgres.name }}-$(date \"+%Y-%m-%d\").gz"
{{ else if eq .Values.upload.type "azure" -}}
- "az login --federated-token \"$(cat $AZURE_FEDERATED_TOKEN_FILE)\" --service-principal -u $AZURE_CLIENT_ID -t $AZURE_TENANT_ID;
  az storage blob upload-batch --account-name {{ .Values.upload.azure.storageAccount }} -s /backup -d {{ .Values.upload.azure.containerName }}/{{ .Values.upload.azure.prefix }}-$(date \"+%Y-%m-%d\") --auth-mode login"
{{- else }}
{{ fail "Invalid storage type" }}
{{- end -}}
{{- end -}}
