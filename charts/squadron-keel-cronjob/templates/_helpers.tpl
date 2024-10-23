{{/*
Expand the name of the chart.
*/}}
{{- define "keel.cronjob.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "keel.cronjob.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- tpl .Values.fullnameOverride . | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "keel.cronjob.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "keel.cronjob.chart-revision" -}}
{{- printf "%s-%s-%d" .Chart.Name .Chart.Version .Release.Revision | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "keel.cronjob.labels" -}}
helm.sh/chart: {{ include "keel.cronjob.chart" . }}
{{ include "keel.cronjob.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "keel.cronjob.selectorLabels" -}}
app.kubernetes.io/name: {{ include "keel.cronjob.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Networking labels
*/}}
{{- define "keel.cronjob.networkingLabels" -}}
{{- if .Values.networkPolicy.enabled }}
{{- range .Values.networkPolicy.rules }}
networking/{{ . }}: "true"
{{- end}}
{{- if .Values.networkPolicy.ingress.enabled }}
{{- if .Values.networkPolicy.ingress.allowExternal }}
kubernetes.io/networking.name: {{ include "keel.cronjob.fullname" . }}
{{- end}}
{{- end}}
{{- end }}
{{- end }}

{{/*
Create the name of the namespace
*/}}
{{- define "keel.cronjob.namespace" -}}
{{- default .Release.Namespace .Values.namespaceOverride }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "keel.cronjob.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "keel.cronjob.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Keel standard envs
{{- include "keel.cronjob.env.log" . | nindent 12 }}
*/}}
{{- define "keel.cronjob.env.log" -}}
- name: LOG_MODE
  value: "{{ .Values.log.mode }}"
- name: LOG_LEVEL
  value: "{{ .Values.log.level }}"
{{- if eq .Values.log.mode "dev" }}
- name: LOG_DISABLE_CALLER
  value: "false"
- name: LOG_DISABLE_STACKTRACE
  value: "true"
{{- end }}
{{- end -}}

{{/*
Squadron standard envs
{{- include "keel.cronjob.env.squadron" . | nindent 12 }}
*/}}
{{- define "keel.cronjob.env.squadron" -}}
{{- if .Values.fleet }}
- name: FLEET
  value: {{ .Values.fleet | quote }}
{{- end }}
{{- if .Values.squadron }}
- name: SQUADRON
  value: {{ .Values.squadron | quote }}
{{- end }}
{{- if .Values.unit }}
- name: UNIT
  value: {{ .Values.unit | quote }}
{{- end }}
{{- end -}}

{{/*
OpenTelemetry standard envs
{{- include "keel.cronjob.env.opentelemetry" . | nindent 12 }}
*/}}
{{- define "keel.cronjob.env.opentelemetry" -}}
- name: OTEL_ENABLED
  value: "{{ .Values.otel.enabled }}"
- name: OTEL_SERVICE_NAME
  value: {{ include "keel.cronjob.fullname" . | quote }}
- name: OTEL_TRACE_RATIO
  value: "{{ .Values.otel.ratio }}"
- name: OTEL_GORM_ENABLED
  value: "{{ .Values.otel.gorm.enabled }}"
- name: OTEL_GORM_SQL_PARAMETERS_ENABLED
  value: "{{ not .Values.otel.gorm.sqlParametersDisabled }}"
- name: OTEL_MONGO_ENABLED
  value: "{{ .Values.otel.mongo.enabled }}"
- name: OTEL_MONGO_COMMAND_ATTRIBUTE_DISABLED
  value: "{{ .Values.otel.mongo.commandAttributeDisabled }}"
- name: OTEL_GOTSRPC_ENABLED
  value: "{{ .Values.otel.gotsrpc.enabled }}"
- name: OTEL_GOTSRPC_PAYLOAD_ATTRIBUTE_DISABLED
  value: "{{ .Values.otel.gotsrpc.payloadAttributeDisabled }}"
- name: OTEL_EXPORTER_OTLP_INSECURE
  value: "{{ .Values.otel.otlp.insecure }}"
- name: OTEL_EXPORTER_OTLP_ENDPOINT
  value: "{{ .Values.otel.otlp.endpoint }}"
{{- end -}}
