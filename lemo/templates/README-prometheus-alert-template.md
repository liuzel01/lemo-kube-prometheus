# PrometheusAlert 模板备份（hash）

此目录用于保存 `prometheus-alert-center` 数据库内的模板正文，避免组件重建后模板丢失。

## 当前模板

- 名称：`prometheus-feishu-app`
- 文件：`prometheus-feishu-app.tpl`
- 用途：hash 集群 `Alertmanager -> prometheus-alert-center` webhook 的 `tpl=prometheus-feishu-app`

## 回灌到集群（重建后）

```bash
# 1) 将模板文件拷到 pod
kubectl --context hash -n monitoring cp \
  lemo/templates/prometheus-feishu-app.tpl \
  $(kubectl --context hash -n monitoring get pod -l app=prometheus-alert-center -o jsonpath='{.items[0].metadata.name}'):/tmp/prometheus-feishu-app.tpl

# 2) 写回 sqlite（按模板名更新）
kubectl --context hash -n monitoring exec deploy/prometheus-alert-center -- sh -lc \
  "sqlite3 /app/db/PrometheusAlertDB.db \"update prometheus_alert_d_b set tpl=replace(readfile('/tmp/prometheus-feishu-app.tpl'), char(13), '') where tplname='prometheus-feishu-app';\""

# 3) 校验长度（非 0 即成功）
kubectl --context hash -n monitoring exec deploy/prometheus-alert-center -- sh -lc \
  "sqlite3 /app/db/PrometheusAlertDB.db \"select id,tplname,length(tpl) from prometheus_alert_d_b where tplname='prometheus-feishu-app';\""
```

> 注意：该模板存储在 PrometheusAlert 的 sqlite 中，不在 ConfigMap/Secret 中；仅改 YAML 不会自动覆盖 DB 模板正文。
