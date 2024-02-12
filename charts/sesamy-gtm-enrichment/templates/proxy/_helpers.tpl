{{/*
proxy fullname
*/}}
{{- define "sesamy.gtm-enrichment.proxy.fullname" -}}
{{ include "sesamy.gtm-enrichment.fullname" . }}-proxy
{{- end }}

{{/*
proxy common labels
*/}}
{{- define "sesamy.gtm-enrichment.proxy.labels" -}}
{{ include "sesamy.gtm-enrichment.labels" . }}
app.kubernetes.io/component: proxy
{{- end }}

{{/*
proxy selector labels
*/}}
{{- define "sesamy.gtm-enrichment.proxy.selectorLabels" -}}
{{ include "sesamy.gtm-enrichment.selectorLabels" . }}
app.kubernetes.io/component: proxy
{{- end }}
