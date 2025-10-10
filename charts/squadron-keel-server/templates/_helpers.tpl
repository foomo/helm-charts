{{/*
Expand the name of the chart.
*/}}
{{- define "keel.server.name" }}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "keel.server.fullname" }}
{{- if .Values.fullnameOverride }}
{{- tpl .Values.fullnameOverride . | trunc 63 | trimSuffix "-" }}
{{- else if and .Values.global.foomo.squadron.name .Values.global.foomo.squadron.unit }}
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
{{- define "keel.server.chart" }}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "keel.server.chart-revision" }}
{{- printf "%s-%s-%d" .Chart.Name .Chart.Version .Release.Revision | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "keel.server.labels" }}
{{- if .Values.server.labelsOverride }}
{{ tpl (trim .Values.server.labelsOverride) . }}
{{- else }}
{{ include "keel.server.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.image.tag | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ include "keel.server.chart" . }}
{{- end }}

{{/*
Pod labels
*/}}
{{- define "keel.server.podLabels" }}
{{- if .Values.server.selectorLabelsOverride }}
{{ tpl (trim .Values.server.selectorLabelsOverride) . }}
{{- else }}
{{ include "keel.server.labels" . }}
{{ include "keel.server.networkingLabels" . }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "keel.server.selectorLabels" }}
{{- if .Values.server.selectorLabelsOverride }}
{{ tpl (trim .Values.server.selectorLabelsOverride) . }}
{{- else if .Values.global.foomo.withDeprecatedSelectorLabels }}
app.kubernetes.io/name: {{ include "keel.server.fullname" . }}
app.kubernetes.io/component: foomo-keel-server
{{- else if .Values.global.foomo.withDeprecatedSelectorLabelsV2 }}
app.kubernetes.io/name: {{ include "keel.server.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- else }}
app.kubernetes.io/name: {{ .Release.Name }}
{{- end }}
{{- end }}


{{/*
Networking labels
*/}}
{{- define "keel.server.networkingLabels" }}
{{- if .Values.networkPolicy.enabled }}
{{- range .Values.networkPolicy.rules }}
networking/{{ . }}: "true"
{{- end}}
{{- if .Values.networkPolicy.ingress.enabled }}
{{- if .Values.networkPolicy.ingress.allowExternal }}
kubernetes.io/networking.name: {{ include "keel.server.fullname" . }}
{{- end}}
{{- end}}
{{- end }}
{{- end }}

{{/*
Create the name of the namespace
*/}}
{{- define "keel.server.namespace" }}
{{- default .Release.Namespace .Values.namespaceOverride }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "keel.server.serviceAccountName" }}
{{- if .Values.serviceAccount.create }}
{{- default (include "keel.server.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Keel standard envs
{{- include "keel.server.env.log" . | nindent 12 }}
*/}}
{{- define "keel.server.env.log" }}
- name: LOG_MODE
  value: "{{ .Values.log.mode }}"
- name: LOG_LEVEL
  value: "{{ .Values.log.level }}"
- name: LOG_DISABLE_CALLER
  value: "{{ .Values.log.disableCaller }}"
{{- if eq .Values.log.mode "dev" }}
- name: LOG_DISABLE_STACKTRACE
  value: "true"
{{- end }}
{{- end }}

{{/*
Foomo keel envs
{{- include "keel.server.env.keel" . | nindent 12 }}
*/}}
{{- define "keel.server.env.keel" }}
- name: SERVICE_HEALTHZ_ENABLED
  value: "{{ .Values.keel.service.healthz.enabled }}"
- name: SERVICE_PPROF_ENABLED
  value: "{{ .Values.keel.service.pprof.enabled }}"
- name: SERVICE_VIPER_ENABLED
  value: "{{ .Values.keel.service.viper.enabled }}"
- name: SERVICE_ZAP_ENABLED
  value: "{{ .Values.keel.service.zap.enabled }}"
- name: SERVICE_README_ENABLED
  value: "{{ .Values.keel.service.readme.enabled }}"
- name: SERVICE_PROMETHEUS_ENABLED
  value: "{{ .Values.keel.service.prometheus.enabled }}"
{{- end }}

{{/*
Squadron standard envs
{{- include "keel.server.env.squadron" . | nindent 12 }}
*/}}
{{- define "keel.server.env.squadron" }}
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
{{- end }}

{{/*
OpenTelemetry standard envs
{{- include "keel.server.env.opentelemetry" . | nindent 12 }}
*/}}
{{- define "keel.server.env.opentelemetry" }}
- name: OTEL_ENABLED
  value: "{{ .Values.otel.enabled }}"
- name: OTEL_SERVICE_NAME
  value: {{ .Release.Name | quote }}
- name: OTEL_SERVICE_NAMESPACE
  value: {{ .Release.Namespace | quote }}
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
- name: OTEL_PROFILE_BLOCK_ENABLED
  value: "{{ index .Values "otel" "profile" "block" "enabled" }}"
- name: OTEL_PROFILE_MUTEX_ENABLED
  value: "{{ .Values.otel.profile.mutex.enabled }}"
- name: PYROSCOPE_ADHOC_SERVER_ADDRESS
  value: "{{ .Values.otel.profile.endpoint }}"
{{- end }}

{{/*
Deployment force recreate annotions
{{- include "keel.server.annotations.recreatePod" . | nindent 8 }}
*/}}
{{- define "keel.server.annotations.recreatePod" }}
{{- if .Values.image.recreate }}
helm.sh/chart: {{ include "keel.server.chart-revision" . }}
{{- end }}
{{- end }}
