# Expand the name of the chart.
{{- define "chart.name" -}}
{{ .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end -}}


# Create a default fully qualified app name.
# We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
# If release name contains chart name it will be used as a full name.
{{- define "chart.fullname" -}}
{{- if contains .Chart.Name .Release.Name -}}
{{ .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end -}}
{{ printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end -}}


# Create chart name and version as used by the chart label.?
{{- define "chart.label" -}}
{{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end -}}


# Selector labels
{{- define "deployment.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ printf "%s-%s" .Release.Name "postgres" }}
{{- end -}}


# Common labels
{{- define "chart.labels" -}}
helm.sh/chart: {{ include "chart.label" . }}
helm.sh/release: {{ .Release.Name }}
app.kubernetes.io/component: database
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service | lower }}
{{- end -}}
