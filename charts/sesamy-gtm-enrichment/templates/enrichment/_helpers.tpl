{{/*
enrichment fullname
*/}}
{{- define "sesamy.gtm-enrichment.enrichment.fullname" -}}
{{ include "sesamy.gtm-enrichment.fullname" . }}-enrichment
{{- end }}

{{/*
enrichment common labels
*/}}
{{- define "sesamy.gtm-enrichment.enrichment.labels" -}}
{{ include "sesamy.gtm-enrichment.labels" . }}
app.kubernetes.io/component: enrichment
{{- end }}

{{/*
enrichment selector labels
*/}}
{{- define "sesamy.gtm-enrichment.enrichment.selectorLabels" -}}
{{ include "sesamy.gtm-enrichment.selectorLabels" . }}
app.kubernetes.io/component: enrichment
{{- end }}
