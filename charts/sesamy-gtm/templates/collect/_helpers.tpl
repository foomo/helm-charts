{{/*
collect fullname
*/}}
{{- define "sesamy.gtm.collect.fullname" -}}
{{ include "sesamy.gtm.fullname" . }}-collect
{{- end }}

{{/*
collect common labels
*/}}
{{- define "sesamy.gtm.collect.labels" -}}
{{ include "sesamy.gtm.labels" . }}
app.kubernetes.io/component: collect
{{- end }}

{{/*
collect selector labels
*/}}
{{- define "sesamy.gtm.collect.selectorLabels" -}}
{{ include "sesamy.gtm.selectorLabels" . }}
app.kubernetes.io/component: collect
{{- end }}
