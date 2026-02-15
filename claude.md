# Claude AI Context

Ansible infrastructure automation: monitoring, provisioning, deployment, configuration management.

## Core Capabilities
1. **Provisioning**: Deploy complete servers from scratch (`site.yml` or `provision-*` playbooks)
2. **Deployment**: Update applications with branch selection (`./deploy`)
3. **Configuration**: Modular roles for `python_app`, `nginx`, and monitoring
4. **Monitoring**: Dedicated monitor server (brain + probe); Prometheus, Grafana, Loki, Alertmanager, Blackbox Exporter; Promtail on app servers only.

## Structure
- `inventories/`: Environment specific configs (prod, sample)
- `inventories/prod/group_vars/`: Production variables (all/all.yml, all/secrets.yml, backend.yml, salome.yml, monitoring.yml)
- `roles/`:
  - `python_app`: Generic role for all Python web services
  - `nginx`: Automated Nginx configuration for backend and salome
  - `prometheus`, `grafana`, `loki`, `alertmanager`, `blackbox_exporter`: Monitoring stack (monitor server)
  - `promtail`, `node_exporter`: Log/metric agents (app servers + monitor)
  - `common`: Base system setup
- `playbooks/`: provision-*, deploy.yml, manage-services.yml, verify-servers.yml
- `docs/`: Consolidated documentation (Architecture, Operations, Configuration)

## Quick Commands
```bash
# Provisioning
./provision monitor         # Monitor server (brain + probe)
./provision backend         # Backend app server
./provision salome          # Salome app server
./provision verify          # Verify all servers

# Deployment
./deploy <service> <branch> # Deploy application
./sync                      # Sync deployment scripts

# Management
ansible-playbook -i inventories/prod/hosts.ini site.yml
ansible-playbook -i inventories/prod/hosts.ini playbooks/manage-services.yml
```

## Infrastructure Model
- **Monitor server** (brain + probe):
  - **Brain** (metrics + logs): Prometheus, Grafana, Loki, Alertmanager
  - **Probe**: Blackbox Exporter
  - Node Exporter, Promtail (optional, for monitor host logs)
- **Backend server** (api.mek-lab.com) — Application servers:
  - FastAPI: `backendserver`, `geoserver`, `llmserver`
  - Promtail (ships logs to Loki on monitor)
  - Nginx + Certbot
- **Salome server** (salome.mek-lab.com) — Application servers:
  - FastAPI: `salomeserver`
  - Promtail (ships logs to Loki on monitor)
  - Nginx + Certbot

## Standard Service Names
- `backendserver` (port 8000)
- `geoserver` (port 8001)
- `llmserver` (port 8002)
- `salomeserver` (port 8000)

## Documentation Hierarchy
- `README.md`: Entry point & Quick Reference
- `docs/ARCHITECTURE.md`: Technical overview & data flows
- `docs/OPERATIONS.md`: Provisioning & deployment guides
- `docs/CONFIGURATION.md`: Secrets, env files, & Nginx
