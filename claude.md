# Claude AI Context

Ansible project deploying monitoring stack: Prometheus, Grafana, Loki, Promtail, Node Exporter.

## Structure
- `inventories/`: prod/sample host definitions
- `group_vars/`: Variables (all.yml, secrets.yml)
- `roles/`: common, node_exporter, prometheus, grafana, loki, promtail
- `site.yml`: Main playbook

## Status
✅ common, node_exporter roles complete
⚠️ prometheus (template only), grafana, loki, promtail (empty)

## Key Patterns
- Inventory groups: `monitoring` (central services), `app` (monitored servers)
- Prometheus uses Jinja2 for dynamic target discovery
- Services: systemd with dedicated system users, no-login shells
- Variables centralized in group_vars/all.yml

## Implementation Pattern (see node_exporter)
1. Create system user
2. Download/extract binary
3. Install to /usr/local/bin/
4. Create systemd service
5. Enable and start

## Prometheus Scrape Jobs
- prometheus: localhost:9090
- node_exporters: all servers:9100
- fastapi: app servers:8000/metrics

## Commands
```bash
ansible-playbook -i inventories/prod/hosts.ini site.yml
ansible-playbook -i inventories/prod/hosts.ini site.yml --tags role_name
ansible-playbook -i inventories/prod/hosts.ini site.yml --check
```
