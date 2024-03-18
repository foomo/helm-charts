{{/*
default fullname
*/}}
{{- define "contentserver.contentserver.fullname" -}}
{{ include "contentserver.fullname" . }}
{{- end }}

{{/*
default common labels
*/}}
{{- define "contentserver.contentserver.labels" -}}
{{ include "contentserver.labels" . }}
{{- end }}

{{/*
default selector labels
*/}}
{{- define "contentserver.contentserver.selectorLabels" -}}
{{ include "contentserver.selectorLabels" . }}
{{- end }}
