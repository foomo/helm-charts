{{/*
tagging fullname
*/}}
{{- define "sesamy.gtm.tagging.fullname" -}}
{{ include "sesamy.gtm.fullname" . }}-tagging
{{- end }}

{{/*
tagging common labels
*/}}
{{- define "sesamy.gtm.tagging.labels" -}}
{{ include "sesamy.gtm.labels" . }}
app.kubernetes.io/component: tagging
{{- end }}

{{/*
tagging selector labels
*/}}
{{- define "sesamy.gtm.tagging.selectorLabels" -}}
{{ include "sesamy.gtm.selectorLabels" . }}
app.kubernetes.io/component: tagging
{{- end }}
