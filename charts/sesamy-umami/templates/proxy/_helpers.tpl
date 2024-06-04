{{/*
proxy fullname
*/}}
{{- define "sesamy.umami.proxy.fullname" -}}
{{ include "sesamy.umami.fullname" . }}-proxy
{{- end }}

{{/*
proxy common labels
*/}}
{{- define "sesamy.umami.proxy.labels" -}}
{{ include "sesamy.umami.labels" . }}
app.kubernetes.io/component: proxy
{{- end }}

{{/*
proxy selector labels
*/}}
{{- define "sesamy.umami.proxy.selectorLabels" -}}
{{ include "sesamy.umami.selectorLabels" . }}
app.kubernetes.io/component: proxy
{{- end }}
