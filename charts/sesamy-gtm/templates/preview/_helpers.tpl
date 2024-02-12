{{/*
preview fullname
*/}}
{{- define "sesamy.gtm.preview.fullname" -}}
{{ include "sesamy.gtm.fullname" . }}-preview
{{- end }}

{{/*
preview common labels
*/}}
{{- define "sesamy.gtm.preview.labels" -}}
{{ include "sesamy.gtm.labels" . }}
app.kubernetes.io/component: preview
{{- end }}

{{/*
preview selector labels
*/}}
{{- define "sesamy.gtm.preview.selectorLabels" -}}
{{ include "sesamy.gtm.selectorLabels" . }}
app.kubernetes.io/component: preview
{{- end }}
