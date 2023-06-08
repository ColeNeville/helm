# Expand the name of the chart.
{{- define "chart.name" -}}
{{ .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end -}}

# Create a default fully qualified app name.
# We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
# If release name contains chart name it will be used as a full name.
{{- define "homeassistant.basename" -}}
{{- if contains .Chart.Name .Release.Name -}}
{{ .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else -}}
{{ printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end -}}
{{- end -}}

# Alias for basename
{{- define "homeassistant.fullname" -}}
{{ include "homeassistant.basename" . }}
{{- end -}}

# Create chart name and version as used by the chart label.?
{{- define "homeassistant.label" -}}
{{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end -}}

# Common labels
{{- define "homeassistant.labels" -}}
helm.sh/chart: {{ include "chart.label" . }}
helm.sh/release: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service | lower }}
{{- end -}}

# Selector labels
{{- define "homeassistant.deployment.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}