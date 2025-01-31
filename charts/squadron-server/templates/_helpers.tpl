{{/*
Expand the name of the chart.
*/}}
{{- define "squadron.server.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "squadron.server.fullname" -}}
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
{{- define "squadron.server.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "squadron.server.chart-revision" -}}
{{- printf "%s-%s-%d" .Chart.Name .Chart.Version .Release.Revision | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "squadron.server.labels" -}}
helm.sh/chart: {{ include "squadron.server.chart" . }}
{{ include "squadron.server.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "squadron.server.selectorLabels" -}}
{{ if .Values.global.foomo.withDeprecatedSelectorLabels }}
app.kubernetes.io/name: {{ include "squadron.server.fullname" . }}
app.kubernetes.io/component: foomo-keel-server
{{- else }}
app.kubernetes.io/name: {{ include "squadron.server.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- end }}

{{/*
Networking labels
*/}}
{{- define "squadron.server.networkingLabels" -}}
{{- if .Values.networkPolicy.enabled }}
{{- range .Values.networkPolicy.rules }}
networking/{{ . }}: "true"
{{- end}}
{{- if .Values.networkPolicy.ingress.enabled }}
{{- if .Values.networkPolicy.ingress.allowExternal }}
kubernetes.io/networking.name: {{ include "squadron.server.fullname" . }}
{{- end}}
{{- end}}
{{- end }}
{{- end }}

{{/*
Create the name of the namespace
*/}}
{{- define "squadron.server.namespace" -}}
{{- default .Release.Namespace .Values.namespaceOverride }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "squadron.server.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "squadron.server.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Squadron standard envs
{{- include "squadron.server.env.squadron" . | nindent 12 }}
*/}}
{{- define "squadron.server.env.squadron" -}}
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
Deployment force recreate annotions
{{- include "squadron.server.annotations.recreatePod" . | nindent 8 }}
*/}}
{{- define "squadron.server.annotations.recreatePod" -}}
{{- if .Values.image.recreate }}
helm.sh/chart: {{ include "squadron.server.chart-revision" . }}
{{- end }}
{{- end -}}
