{{/*
pinniped-supervisor fullname
*/}}
{{- define "beam.pinniped.supervisor.fullname" -}}
{{ include "beam.fullname" . }}-pinniped-supervisor
{{- end }}

{{/*
pinniped-supervisor common labels
*/}}
{{- define "beam.pinniped.supervisor.labels" -}}
{{ include "beam.labels" . }}
app.kubernetes.io/component: pinniped-supervisor
{{- end }}

{{/*
pinniped-supervisor selector labels
*/}}
{{- define "beam.pinniped.supervisor.selectorLabels" -}}
{{ include "beam.selectorLabels" . }}
app.kubernetes.io/component: pinniped-supervisor
{{- end }}
