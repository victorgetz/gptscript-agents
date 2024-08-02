{{- define "gptscript-bot.fullname" -}}
{{- include "gptscript-bot.name" . }}-{{ .Release.Name }}
{{- end -}}

{{- define "gptscript-bot.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{- define "gptscript-bot.mergeEnv" -}}
{{- $global := .global -}}
{{- $local := .local -}}
{{- $merged := dict -}}
{{- range $key, $value := $global }}
  {{- $_ := set $merged $key $value }}
{{- end }}
{{- range $key, $value := $local }}
  {{- $_ := set $merged $key $value }}
{{- end }}
{{- $merged }}
{{- end }}