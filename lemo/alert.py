import sys

def generate_alert_rules(services_file, output_file):
    # 读取服务名列表
    with open(services_file, 'r') as f:
        services = [line.strip() for line in f.readlines() if line.strip()]

    # 告警规则模板
    alert_template = """
    - alert: default-{service}
      annotations:
      expr: |
        kube_statefulset_status_replicas_available{{namespace="default",statefulset="{service}"}} < 1
      for: 1m
      labels:
        severity: critical
"""

    # 生成所有告警规则
    with open(output_file, 'w') as f:
        for service in services:
            # 生成告警规则并写入文件
            alert_rule = alert_template.format(service=service)
            f.write(alert_rule)
            f.write('\n')  # 添加空行分隔不同的告警规则

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python script.py <services_file> <output_file>")
        sys.exit(1)
    
    services_file = sys.argv[1]
    output_file = sys.argv[2]
    generate_alert_rules(services_file, output_file)
    print(f"Alert rules have been generated and saved to {output_file}")
