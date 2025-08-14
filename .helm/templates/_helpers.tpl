{{/*
Expand the name of the chart.
*/}}
{{- define "service.name" -}}
{{- default "boxer" .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "app.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := .Chart.Name }}
{{- if contains .Release.Name $name }}
{{- $name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Generate common labels
*/}}
{{- define "app.labels" -}}
helm.sh/chart: {{ include "app.chart" . }}
{{ include "app.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Values.additionalLabels }}
{{ toYaml . }}
{{- end }}
{{- end }}


{{- define "rbac.apiGroups" }}
apiGroups:
  - auth.sneaksanddata.com
{{- end }}

{{- define "rbac.resources.identityProvider" }}
resources:
  - identity-providers
{{- end }}

{{- define "rbac.resources.externalIdentity" }}
resources:
  - external-identities
{{- end }}

{{- define "rbac.resources.cedarEntity" }}
resources:
  - cedar-entities
{{- end }}

{{- define "rbac.resources.schema" }}
resources:
  - cedar-entities
{{- end }}

{{- define "rbac.resources.actionDiscovery" }}
resources:
  - action-discovery-documents
{{- end }}

{{- define "rbac.resources.resourceDiscovery" }}
resources:
  - resource-discovery-documents
{{- end }}

{{- define "rbac.resources.policySet" }}
resources:
  - policy-documents
{{- end }}
