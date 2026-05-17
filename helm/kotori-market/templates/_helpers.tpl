{{/*
Expand the name of the chart.
*/}}
{{- define "kotori-market.name" -}}
{{- .Chart.Name }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kotori-market.labels" -}}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Full image reference: registry/image:tag
*/}}
{{- define "kotori-market.image" -}}
{{- printf "%s/%s:%s" .registry .image .tag }}
{{- end }}
