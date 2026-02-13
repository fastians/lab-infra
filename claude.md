# Claude AI Context

Ansible infrastructure automation: monitoring, provisioning, deployment, configuration management.

## Core Capabilities
1. **Provisioning**: Deploy complete servers from scratch (`site.yml` or `provision-*` playbooks)
2. **Deployment**: Update applications with branch selection (`./deploy`)
3. **Configuration**: Modular roles for `python_app`, `nginx`, and monitoring
4. **Monitoring**: Prometheus, Grafana, Loki, Promtail (aggregated on Backend)

## Structure
- `inventories/`: prod/sample host definitions
- `group_vars/`: Variables (backend.yml, secrets.yml)
- `roles/`:
  - `python_app`: Generic role for all Python web services
  - `nginx`: Automated Nginx configuration for backend
  - `monitoring`: prometheus, grafana, loki, promtail, node_exporter
  - `common`: Base system setup
- `playbooks/`: provision-*, deploy.yml, manage-services.yml, verify-servers.yml
- `docs/`: Consolidated documentation (Architecture, Operations, Configuration)

## Quick Commands
```bash
# Provisioning
./provision salome          # New Salome server
./provision backend         # New Backend server
./provision verify          # Verify all servers

# Deployment
./deploy <service> <branch> # Deploy application
./sync                      # Sync deployment scripts

# Management
ansible-playbook -i inventories/prod/hosts.ini site.yml
ansible-playbook -i inventories/prod/hosts.ini playbooks/manage-services.yml
```

## Infrastructure Model
- **backend-server** (api.mek-lab.com):
  - Services: `backendserver`, `geoserver`, `llmserver`
  - Monitoring: Full stack (Prometheus, Loki, Grafana)
- **salome-server** (salome.mek-lab.com):
  - Services: `salome-fastapi`
  - Proxy: Nginx + Certbot

## Standard Service Names
- `backendserver` (port 8000)
- `geoserver` (port 8001)
- `llmserver` (port 8002)
- `salome-fastapi` (port 8000)

## Documentation Hierarchy
- `README.md`: Entry point & Quick Reference
- `docs/ARCHITECTURE.md`: Technical overview & data flows
- `docs/OPERATIONS.md`: Provisioning & deployment guides
- `docs/CONFIGURATION.md`: Secrets, env files, & Nginx
