{{/*
umami fullname
*/}}
{{- define "sesamy.umami.umami.fullname" -}}
{{ include "sesamy.umami.fullname" . }}-umami
{{- end }}

{{/*
umami common labels
*/}}
{{- define "sesamy.umami.umami.labels" -}}
{{ include "sesamy.umami.labels" . }}
app.kubernetes.io/component: umami
{{- end }}

{{/*
umami selector labels
*/}}
{{- define "sesamy.umami.umami.selectorLabels" -}}
{{ include "sesamy.umami.selectorLabels" . }}
app.kubernetes.io/component: umami
{{- end }}

{{/*
umami database uri
*/}}
{{- define "sesamy.umami.umami.database.uri" -}}
  {{- if .Values.umami.config.database.uri -}}
    {{- printf "%s" (tpl .Values.umami.config.database.uri $) -}}
  {{- else -}}
    {{- printf "postgres://%s:%s@%s/%s" (tpl .Values.umami.config.database.auth.username $) (tpl .Values.umami.config.database.auth.password $) (tpl .Values.umami.config.database.auth.hostname $) (tpl .Values.umami.config.database.auth.database $) -}}
  {{- end -}}
{{- end -}}

{{/*
umami database secret name
*/}}
{{- define "sesamy.umami.umami.database.secretName" -}}
  {{- if .Values.umami.config.database.existingSecret -}}
    {{- printf "%s" (tpl .Values.umami.config.database.existingSecret $) -}}
  {{- else -}}
      {{- printf "%s" (include "sesamy.umami.umami.fullname" .) -}}-db
  {{- end -}}
{{- end -}}

{{/*
umami app secret name
*/}}
{{- define "sesamy.umami.umami.appSecret.secretName" -}}
  {{- if .Values.umami.config.appSecret.existingSecret -}}
    {{- printf "%s" (tpl .Values.umami.config.appSecret.existingSecret $) -}}
  {{- else -}}
      {{- printf "%s" (include "sesamy.umami.umami.fullname" .) -}}-app
  {{- end -}}
{{- end -}}
