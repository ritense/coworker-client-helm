{{/*
Expand the name of the chart.
*/}}
{{- define "coworker-client.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "coworker-client.fullname" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "coworker-client.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | trunc 63 | trimSuffix "-" }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{ include "coworker-client.selectorLabels" . }}
{{- end }}

{{/*
Selector labels (used in both matchLabels and pod labels)
*/}}
{{- define "coworker-client.selectorLabels" -}}
app.kubernetes.io/name: {{ include "coworker-client.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Backend image tag — falls back to appVersion
*/}}
{{- define "coworker-client.backendImage" -}}
{{ .Values.backend.image.repository }}:{{ .Values.backend.image.tag | default .Chart.AppVersion }}
{{- end }}

{{/*
Frontend image tag — falls back to appVersion
*/}}
{{- define "coworker-client.frontendImage" -}}
{{ .Values.frontend.image.repository }}:{{ .Values.frontend.image.tag | default .Chart.AppVersion }}
{{- end }}

{{/*
Name of the backend secret (own or existing)
*/}}
{{- define "coworker-client.secretName" -}}
{{- if .Values.backend.existingSecret }}
{{- .Values.backend.existingSecret }}
{{- else }}
{{- include "coworker-client.fullname" . }}-backend-secret
{{- end }}
{{- end }}
