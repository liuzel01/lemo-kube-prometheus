{{- $var := "https://alertmanager.hashex.vip" -}}
{{- range $k, $v := .alerts }}
{{- if eq $v.status "resolved" -}}
**[Prometheus恢复信息]({{ $v.generatorURL }})**
**告警名称：{{ $v.labels.alertname }}**
告警级别：{{ if $v.labels.level }}{{ $v.labels.level }}{{ else if $v.labels.severity }}{{ $v.labels.severity }}{{ else }}unknown{{ end }}
开始时间：{{ $v.startsAt }}
结束时间：{{ $v.endsAt }}{{ if $v.labels.namespace }}
命名空间：{{ $v.labels.namespace }}{{ end }}{{ if $v.labels.pod }}
Pod：{{ $v.labels.pod }}{{ end }}{{ if $v.labels.container }}
容器：{{ $v.labels.container }}{{ end }}{{ if $v.labels.deployment }}
Deployment：{{ $v.labels.deployment }}{{ end }}{{ if $v.labels.statefulset }}
StatefulSet：{{ $v.labels.statefulset }}{{ end }}{{ if $v.labels.daemonset }}
DaemonSet：{{ $v.labels.daemonset }}{{ end }}{{ if $v.labels.node }}
节点：{{ $v.labels.node }}{{ end }}{{ if $v.labels.instance }}
实例：{{ $v.labels.instance }}{{ end }}{{ if $v.labels.job }}
Job：{{ $v.labels.job }}{{ end }}{{ if $v.annotations.summary }}
摘要：{{ $v.annotations.summary }}{{ end }}{{ if $v.annotations.description }}
详情：{{ $v.annotations.description }}{{ end }}

{{- else -}}
**[Prometheus告警信息]({{ $v.generatorURL }})**
**告警名称：{{ $v.labels.alertname }}**
告警级别：{{ if $v.labels.level }}{{ $v.labels.level }}{{ else if $v.labels.severity }}{{ $v.labels.severity }}{{ else }}unknown{{ end }}
开始时间：{{ $v.startsAt }}{{ if $v.labels.namespace }}
命名空间：{{ $v.labels.namespace }}{{ end }}{{ if $v.labels.pod }}
Pod：{{ $v.labels.pod }}{{ end }}{{ if $v.labels.container }}
容器：{{ $v.labels.container }}{{ end }}{{ if $v.labels.deployment }}
Deployment：{{ $v.labels.deployment }}{{ end }}{{ if $v.labels.statefulset }}
StatefulSet：{{ $v.labels.statefulset }}{{ end }}{{ if $v.labels.daemonset }}
DaemonSet：{{ $v.labels.daemonset }}{{ end }}{{ if $v.labels.node }}
节点：{{ $v.labels.node }}{{ end }}{{ if $v.labels.instance }}
实例：{{ $v.labels.instance }}{{ end }}{{ if $v.labels.job }}
Job：{{ $v.labels.job }}{{ end }}{{ if $v.annotations.summary }}
摘要：{{ $v.annotations.summary }}{{ end }}{{ if $v.annotations.description }}
详情：{{ $v.annotations.description }}{{ end }}

{{- end }}
{{- end }}
{{- $urimsg := "" -}}{{- range $key, $value := .commonLabels -}}{{- $urimsg = print $urimsg $key "%3D%22" $value "%22%2C" -}}{{- end }}
[**点我屏蔽该告警**]({{ $var }}/#/silences/new?filter=%7B{{ SplitString $urimsg 0 -3 }}%7D)
