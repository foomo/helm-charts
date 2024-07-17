{{/*
pinniped-concierge fullname
*/}}
{{- define "beam.pinniped.concierge.fullname" -}}
{{ include "beam.fullname" . }}-pinniped-concierge
{{- end }}

{{/*
pinniped-concierge common labels
*/}}
{{- define "beam.pinniped.concierge.labels" -}}
{{ include "beam.labels" . }}
app.kubernetes.io/component: pinniped-concierge
{{- end }}

{{/*
pinniped-concierge selector labels
*/}}
{{- define "beam.pinniped.concierge.selectorLabels" -}}
{{ include "beam.selectorLabels" . }}
app.kubernetes.io/component: pinniped-concierge
{{- end }}
