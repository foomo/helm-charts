{{/*
proxy fullname
*/}}
{{- define "sesamy.gtm.proxy.fullname" -}}
{{ include "sesamy.gtm.fullname" . }}-proxy
{{- end }}

{{/*
proxy common labels
*/}}
{{- define "sesamy.gtm.proxy.labels" -}}
{{ include "sesamy.gtm.labels" . }}
app.kubernetes.io/component: proxy
{{- end }}

{{/*
proxy selector labels
*/}}
{{- define "sesamy.gtm.proxy.selectorLabels" -}}
{{ include "sesamy.gtm.selectorLabels" . }}
app.kubernetes.io/component: proxy
{{- end }}
