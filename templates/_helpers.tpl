{{/*
Expand the name of the chart.
*/}}
{{- define "sqlpad.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "sqlpad.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "sqlpad.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "sqlpad.labels" -}}
helm.sh/chart: {{ include "sqlpad.chart" . }}
{{ include "sqlpad.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "sqlpad.selectorLabels" -}}
app.kubernetes.io/name: {{ include "sqlpad.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "sqlpad.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "sqlpad.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Init container for mariadb-dependent pods
*/}}
{{- define "sqlpad.initWaitMariaDB" }}
- name: init-mariadb
  image: busybox
  command: ["sh", "-c", "until nc -zv {{ include "sqlpad.name" . }}-mariadb 3306 -w1; do echo waiting for mariadb...; sleep 2; done;"]
{{- end }}

{{/*
Create a database connection string for the internal database
*/}}
{{- define "sqlpad.mariadbConnection" -}}
{{- if .Values.mariadb.enabled }}
mariadb://{{ .Values.mariadb.auth.username }}:{{ .Values.mariadb.auth.password }}@{{ include "sqlpad.name" . }}-mariadb:3306/{{ .Values.mariadb.auth.database }}
{{- end }}
{{- end }}
