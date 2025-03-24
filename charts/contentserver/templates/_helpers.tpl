{{/*
Expand the name of the chart.
*/}}
{{- define "contentserver.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "contentserver.fullname" -}}
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
{{- define "contentserver.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "contentserver.labels" -}}
helm.sh/chart: {{ include "contentserver.chart" . }}
{{ include "contentserver.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "contentserver.selectorLabels" -}}
app.kubernetes.io/name: {{ include "contentserver.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "contentserver.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "contentserver.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the namespace
*/}}
{{- define "contentserver.namespace" -}}
{{- default .Release.Namespace .Values.namespaceOverride }}
{{- end }}

{{/*
Keel standard envs
{{- include "contentserver.env.log" . | nindent 12 }}
*/}}
{{- define "contentserver.env.log" -}}
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
OpenTelemetry standard envs
{{- include "contentserver.env.opentelemetry" . | nindent 12 }}
*/}}
{{- define "contentserver.env.opentelemetry" -}}
- name: OTEL_ENABLED
  value: "{{ .Values.otel.enabled }}"
- name: OTEL_SERVICE_NAME
  value: {{ .Release.Name | quote }}
- name: OTEL_TRACE_RATIO
  value: "{{ .Values.otel.ratio }}"
- name: OTEL_EXPORTER_OTLP_INSECURE
  value: "{{ .Values.otel.otlp.insecure }}"
- name: OTEL_EXPORTER_OTLP_ENDPOINT
  value: "{{ .Values.otel.otlp.endpoint }}"
{{- end -}}
