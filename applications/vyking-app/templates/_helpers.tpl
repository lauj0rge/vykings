{{- define "vyking-app.fullname" -}}
{{- .Release.Name -}}
{{- end -}}

{{- define "vyking-app.frontendFullname" -}}
{{- printf "%s-frontend" .Release.Name -}}
{{- end -}}

{{- define "vyking-app.backendFullname" -}}
{{- printf "%s-backend" .Release.Name -}}
{{- end -}}

{{- define "vyking-app.environment" -}}
{{- default "dev" .Values.global.environment -}}
{{- end -}}
