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
{{- else if eq .Values.dump.type "mongodb" -}}
{{ .Values.dump.mongodb.image }}
{{- else }}
{{ fail "Invalid dump type" }}
{{- end -}}
{{- end -}}

{{/*
Retrieve dump instance name
*/}}
{{- define "backups.dump.instanceName" -}}
{{- if eq .Values.dump.type "contentful" -}}
contentful
{{- else if eq .Values.dump.type "postgres" -}}
{{ .Values.dump.postgres.name }}
{{- else if eq .Values.dump.type "mongodb" -}}
{{ .Values.dump.mongodb.name }}
{{- else }}
{{ fail "Invalid dump type" }}
{{- end -}}
{{- end -}}

{{- define "backups.dump.secrets" -}}
{{- if eq .Values.dump.type "contentful" -}}
TOKEN: {{ .Values.dump.contentful.password | quote }}
SPACE_ID: {{ .Values.dump.contentful.spaceId | quote }}
{{- else if eq .Values.dump.type "postgres" -}}
PGUSER: {{ .Values.dump.postgres.user | quote }}
PGPASSWORD: {{ .Values.dump.postgres.password | quote }}
PGENDPOINT: {{ .Values.dump.postgres.host | quote }}
PGPORT: {{ .Values.dump.postgres.port | quote }}
{{- else if eq .Values.dump.type "mongodb" -}}
MONGODB_USER: {{ .Values.dump.mongodb.user | quote }}
MONGODB_PASSWORD: {{ .Values.dump.mongodb.password | quote }}
MONGODB_HOST: {{ .Values.dump.mongodb.host | quote }}
MONGODB_PORT: {{ .Values.dump.mongodb.port | quote }}
{{- else }}
{{ fail "Invalid dump type" }}
{{- end -}}
{{- end -}}

{{- define "backups.upload.secrets" -}}
{{- if eq .Values.upload.type "s3" -}}
{{- if .Values.upload.s3.accessKey }}
AWS_ACCESS_KEY_ID: {{ .Values.upload.s3.accessKey | quote }}
{{- end }}
{{- if .Values.upload.s3.secretAccessKey }}
AWS_SECRET_ACCESS_KEY: {{ .Values.upload.s3.secretAccessKey | quote }}
{{- end }}
{{- if .Values.upload.s3.region }}
AWS_DEFAULT_REGION: {{ .Values.upload.s3.region | quote }}
{{- end }}
{{- else if eq .Values.upload.type "gcs" -}}
{{- if .Values.upload.gcs.projectId }}
GCP_PROJECT: {{ .Values.upload.gcs.projectId | quote }}
CLOUDSDK_CORE_PROJECT: {{ .Values.upload.gcs.projectId | quote }}
{{- end }}
{{- else if eq .Values.upload.type "azure" -}}
{{- if .Values.upload.azure.tenantId }}
AZURE_TENANT_ID: {{ .Values.upload.azure.tenantId | quote }}
{{- end }}
{{- if .Values.upload.azure.clientId }}
AZURE_CLIENT_ID: {{ .Values.upload.azure.clientId | quote }}
{{- end }}
{{- else if eq .Values.upload.type "do" -}}
{{- else }}
{{ fail "Invalid storage type" }}
{{- end -}}
{{- end -}}

{{- define "backups.dump.dumpCommand" -}}
{{- $instanceName := include "backups.dump.instanceName" . -}}
{{- if eq .Values.dump.type "contentful" }}
- "/bin/sh"
- "-c"
- "/usr/local/bin/contentful space export --use-verbose-renderer --management-token=\"$TOKEN\" --space-id=\"$SPACE_ID\" --export-dir=/backup/export --max-allowed-limit=100 --download-assets --include-archived --include-drafts && tar -czf /backup/{{ $instanceName }}-$(date \"+%Y-%m-%d\").gz -C /backup/export ."
{{- else if eq .Values.dump.type "postgres" }}
- "/bin/sh"
- "-c"
{{- if eq .Values.dump.postgres.type "RDS" }}
- "pg_dumpall --no-role-passwords -v --exclude-database=rdsadmin {{ with .Values.dump.postgres.port }} -p {{ . }} {{- end }} {{ with .Values.dump.postgres.host }} -h {{ . }} {{- end }} -U $PGUSER | gzip > /backup/{{ $instanceName }}-$(date \"+%Y-%m-%d\").gz"
{{- else if eq .Values.dump.postgres.type "CloudSQL" }}
- "pg_dumpall --no-role-passwords -v --exclude-database=cloudsqladmin --exclude-database=template* {{ with .Values.dump.postgres.port }} -p {{ . }} {{- end }} {{ with .Values.dump.postgres.host }} -h {{ . }} {{- end }} -U $PGUSER | gzip > /backup/{{ $instanceName }}-$(date \"+%Y-%m-%d\").gz"
{{- else if eq .Values.dump.postgres.type "AzurePostgres" }}
#TODO dump command for azure
- "pg_dumpall --no-role-passwords -v --exclude-database=rdsadmin {{ with .Values.dump.postgres.port }} -p {{ . }} {{- end }} {{ with .Values.dump.postgres.host }} -h {{ . }} {{- end }} -U $PGUSER | gzip > /backup/{{ $instanceName }}-$(date \"+%Y-%m-%d\").gz"
{{- else if eq .Values.dump.postgres.type "DOPostgres" }}
- "pg_dumpall --no-role-passwords -v --exclude-database=_dodb --exclude-database=template* -l defaultdb {{ with .Values.postgres.port }} -p {{ . }} {{- end }} {{ with .Values.dump.postgres.host }} -h {{ . }} {{- end }} -U $PGUSER | gzip > /backup/{{ $instanceName }}-$(date \"+%Y-%m-%d\").gz"
{{- else if eq .Values.dump.postgres.type "SelfHosted" }}
#TODO dump command for selfhosted
- "pg_dumpall {{ with .Values.dump.postgres.port }} -p {{ . }} {{- end }} {{ with .Values.dump.postgres.host }} -h {{ . }} {{- end }} -U $PGUSER | gzip > /backup/{{ $instanceName }}-$(date \"+%Y-%m-%d\").gz"
{{- else }}
{{ fail "Invalid Postgres provider" }}
{{- end -}}
{{- else if eq .Values.dump.type "mongodb" }}
- "/bin/sh"
- "-c"
- "mongodump --uri=\"mongodb://$MONGODB_USER:$MONGODB_PASSWORD@$MONGODB_HOST:$MONGODB_PORT/?authSource=admin\" --archive=/backup/{{ $instanceName }}-$(date \"+%Y-%m-%d\").gz --gzip"
{{- end -}}
{{- end -}}

{{- define "backups.dump.uploadCommand" -}}
- "/bin/sh"
- "-c"
{{ if eq .Values.upload.type "s3" -}}
- "aws s3 cp /backup/{{ include "backups.dump.instanceName" . }}-$(date \"+%Y-%m-%d\").gz s3://{{ .Values.upload.s3.bucket }}/{{ .Values.upload.s3.prefix }}/{{ include "backups.dump.instanceName" . }}-$(date \"+%Y-%m-%d\").gz {{- if .Values.upload.s3.endpoint }} --endpoint {{ .Values.upload.s3.endpoint }}{{- end }}"
{{ else if eq .Values.upload.type "gcs" -}}
- "gcloud storage cp /backup/{{ include "backups.dump.instanceName" . }}-$(date \"+%Y-%m-%d\").gz gs://{{ .Values.upload.gcs.bucket }}/{{ .Values.upload.gcs.prefix }}/{{ include "backups.dump.instanceName" . }}-$(date \"+%Y-%m-%d\").gz"
{{ else if eq .Values.upload.type "azure" -}}
{{- if and .Values.upload.azure.tenantId .Values.upload.azure.clientId }}
- "az login --service-principal -u ${AZURE_CLIENT_ID} -t ${AZURE_TENANT_ID} --federated-token \"$(cat ${AZURE_FEDERATED_TOKEN_FILE})\" && \
   az storage blob upload-batch --account-name {{ .Values.upload.azure.storageAccount }} -s /backup -d {{ .Values.upload.azure.containerName }}/{{ .Values.upload.azure.prefix }}-$(date \"+%Y-%m-%d\") --auth-mode login"
{{- else }}
- "az storage blob upload-batch --account-name {{ .Values.upload.azure.storageAccount }} -s /backup -d {{ .Values.upload.azure.containerName }}/{{ .Values.upload.azure.prefix }}-$(date \"+%Y-%m-%d\")"
{{- end }}
{{- else }}
{{ fail "Invalid storage type" }}
{{- end -}}
{{- end -}}
