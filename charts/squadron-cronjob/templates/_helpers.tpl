{{/*
Expand the name of the chart.
*/}}
{{- define "squadron.cronjob.name" }}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "squadron.cronjob.fullname" }}
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
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "squadron.cronjob.chart" }}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "squadron.cronjob.chart-revision" }}
{{- printf "%s-%s-%d" .Chart.Name .Chart.Version .Release.Revision | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "squadron.cronjob.labels" }}
{{- if .Values.cronjob.labelsOverride }}
{{ tpl (trim .Values.cronjob.labelsOverride) . }}
{{- else }}
{{ include "squadron.cronjob.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.image.tag | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ include "squadron.cronjob.chart" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "squadron.cronjob.selectorLabels" }}
{{- if .Values.cronjob.selectorLabelsOverride }}
{{ tpl (trim .Values.cronjob.selectorLabelsOverride) . }}
{{- else }}
app.kubernetes.io/name: {{ .Release.Name }}
{{- end }}
{{- end }}

{{/*
Networking labels
*/}}
{{- define "squadron.cronjob.networkingLabels" }}
{{- if .Values.networkPolicy.enabled }}
{{- range .Values.networkPolicy.rules }}
networking/{{ . }}: "true"
{{- end}}
{{- if .Values.networkPolicy.ingress.enabled }}
{{- if .Values.networkPolicy.ingress.allowExternal }}
kubernetes.io/networking.name: {{ include "squadron.cronjob.fullname" . }}
{{- end}}
{{- end}}
{{- end }}
{{- end }}

{{/*
Create the name of the namespace
*/}}
{{- define "squadron.cronjob.namespace" }}
{{- default .Release.Namespace .Values.namespaceOverride }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "squadron.cronjob.serviceAccountName" }}
{{- if .Values.serviceAccount.create }}
{{- default (include "squadron.cronjob.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Squadron standard envs
{{- include "squadron.cronjob.env.squadron" . | nindent 12 }}
*/}}
{{- define "squadron.cronjob.env.squadron" }}
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

