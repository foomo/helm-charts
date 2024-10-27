{{/*
Expand the name of the chart.
*/}}
{{- define "nextjs.server.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "nextjs.server.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- tpl .Values.fullnameOverride . | trunc 63 | trimSuffix "-" -}}
{{- else if and .Values.global.foomo.squadron.name .Values.global.foomo.squadron.unit -}}
{{- printf "%s-%s" .Values.global.foomo.squadron.name .Values.global.foomo.squadron.unit | trunc 63 | trimSuffix "-" -}}
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
{{- define "nextjs.server.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "nextjs.server.chart-revision" -}}
{{- printf "%s-%s-%d" .Chart.Name .Chart.Version .Release.Revision | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "nextjs.server.labels" -}}
helm.sh/chart: {{ include "nextjs.server.chart" . }}
{{ include "nextjs.server.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "nextjs.server.selectorLabels" -}}
{{ if ((.Values.global).foomo).withDeprecatedSelectorLabels }}
app.kubernetes.io/name: {{ include "nextjs.server.fullname" . }}
app.kubernetes.io/component: "nextjs"
{{ else }}
app.kubernetes.io/name: {{ include "nextjs.server.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- end }}

{{/*
Networking labels
*/}}
{{- define "nextjs.server.networkingLabels" -}}
{{- if .Values.networkPolicy.enabled }}
{{- range .Values.networkPolicy.rules }}
networking/{{ . }}: "true"
{{- end}}
{{- if .Values.networkPolicy.ingress.enabled }}
{{- if .Values.networkPolicy.ingress.allowExternal }}
kubernetes.io/networking.name: {{ include "nextjs.server.fullname" . }}
{{- end}}
{{- end}}
{{- end }}
{{- end }}

{{/*
Create the name of the namespace
*/}}
{{- define "nextjs.server.namespace" -}}
{{- default .Release.Namespace .Values.namespaceOverride }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "nextjs.server.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "nextjs.server.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Keel standard envs
{{- include "nextjs.server.env.log" . | nindent 12 }}
*/}}
{{- define "nextjs.server.env.log" -}}
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
{{- include "nextjs.server.env.squadron" . | nindent 12 }}
*/}}
{{- define "nextjs.server.env.squadron" -}}
{{- if .Values.global.foomo.squadron.fleet }}
- name: FLEET
  value: {{ .Values.global.foomo.squadron.fleet | quote }}
{{- end }}
{{- if .Values.global.foomo.squadron.name }}
- name: SQUADRON
  value: {{ .Values.global.foomo.squadron.name | quote }}
{{- end }}
{{- if .Values.global.foomo.squadron.unit }}
- name: UNIT
  value: {{ .Values.global.foomo.squadron.unit | quote }}
{{- end }}
{{- end -}}

{{/*
OpenTelemetry standard envs
{{- include "nextjs.server.env.opentelemetry" . | nindent 12 }}
*/}}
{{- define "nextjs.server.env.opentelemetry" -}}
- name: OTEL_ENABLED
  value: "{{ .Values.otel.enabled }}"
- name: OTEL_SERVICE_NAME
  value: {{ include "nextjs.server.fullname" . | quote }}
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

{{/*
Deployment force recreate annotions
{{- include "nextjs.server.annotations.recreatePod" . | nindent 8 }}
*/}}
{{- define "nextjs.server.annotations.recreatePod" -}}
{{- if .Values.image.recreate }}
helm.sh/chart: {{ include "nextjs.server.chart-revision" . }}
{{- end }}
{{- end -}}
