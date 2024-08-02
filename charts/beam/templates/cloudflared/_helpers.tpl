{{/*
cloudflared fullname
*/}}
{{- define "beam.cloudflared.fullname" -}}
{{ include "beam.fullname" . }}-cloudflared
{{- end }}

{{/*
cloudflared common labels
*/}}
{{- define "beam.cloudflared.labels" -}}
{{ include "beam.labels" . }}
app.kubernetes.io/component: cloudflared
{{- end }}

{{/*
cloudflared selector labels
*/}}
{{- define "beam.cloudflared.selectorLabels" -}}
{{ include "beam.selectorLabels" . }}
app.kubernetes.io/component: cloudflared
{{- end }}

{{/*
cloudflared-splitter fullname
*/}}
{{- define "beam.cloudflared.splitter.fullname" -}}
{{ include "beam.cloudflared.fullname" . }}-splitter
{{- end }}

{{/*
cloudflared-splitter common labels
*/}}
{{- define "beam.cloudflared.splitter.labels" -}}
{{ include "beam.cloudflared.labels" . }}
app.kubernetes.io/component: cloudflared-splitter
{{- end }}

{{/*
cloudflared-splitter selector labels
*/}}
{{- define "beam.cloudflared.splitter.selectorLabels" -}}
{{ include "beam.cloudflared.selectorLabels" . }}
app.kubernetes.io/component: cloudflared-splitter
{{- end }}
