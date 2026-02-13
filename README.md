# Ansible Monitoring Stack

Ansible playbooks for deploying a complete monitoring stack with Prometheus, Grafana, Loki, and Promtail.

## Overview

This project automates the deployment of a monitoring infrastructure for distributed applications. It sets up:

- **Prometheus**: Metrics collection and alerting
- **Grafana**: Visualization and dashboards
- **Loki**: Log aggregation
- **Promtail**: Log shipping agent
- **Node Exporter**: System metrics collection

## Architecture

```
┌─────────────────┐
│  Grafana        │ ← Visualization
└────────┬────────┘
         │
    ┌────┴────┐
    │         │
┌───▼───┐ ┌──▼───┐
│Prometheus│ │ Loki │ ← Metrics & Logs
└───┬───┘ └──┬───┘
    │         │
┌───▼─────────▼───┐
│  App Servers    │
│  - Node Exporter│
│  - Promtail     │
│  - FastAPI      │
└─────────────────┘
```

## Prerequisites

- Ansible 2.9+
- Python 3.6+
- SSH access to target servers
- Ubuntu/Debian-based target systems

## Quick Start

1. Clone the repository:
```bash
git clone <repository-url>
cd <repository-name>
```

2. Configure your inventory:
```bash
cp inventories/sample/hosts.ini inventories/prod/hosts.ini
# Edit inventories/prod/hosts.ini with your server IPs
```

3. Set up secrets:
```bash
cp group_vars/secrets.example.yml group_vars/secrets.yml
# Edit group_vars/secrets.yml with your credentials
```

4. Run the playbook:
```bash
ansible-playbook -i inventories/prod/hosts.ini site.yml
```

## Configuration

### Inventory Structure

The inventory file defines two groups:

- `backend`: Main backend server running Grafana, Loki, Prometheus, FastAPI services
- `salome`: Salome server with salome-fastapi service

Example:
```ini
[backend]
backend-server ansible_host=BACKEND_SERVER_IP ansible_user=mateen_fastians

[salome]
salome-server ansible_host=SALOME_SERVER_IP ansible_user=mateen_fastians
```

### Variables

Key variables in `group_vars/all.yml`:

- `node_exporter_version`: Version of Node Exporter to install
- Additional component versions and configurations

### Secrets

Store sensitive data in `group_vars/secrets.yml` (gitignored):

- Database credentials
- API keys
- Admin passwords

## Roles

### common
Base system setup and utilities installation.

### node_exporter
Installs and configures Prometheus Node Exporter for system metrics.

### prometheus
Sets up Prometheus server with scrape configurations for:
- Self-monitoring
- Node Exporters across all servers
- FastAPI application metrics

### grafana
Deploys Grafana for visualization and dashboards.

### loki
Configures Loki for centralized log aggregation.

### promtail
Installs Promtail agents to ship logs to Loki.

## Usage

### Deploy Everything
```bash
ansible-playbook -i inventories/prod/hosts.ini site.yml
```

### Deploy Specific Roles
```bash
ansible-playbook -i inventories/prod/hosts.ini site.yml --tags node_exporter
```

### Check Mode (Dry Run)
```bash
ansible-playbook -i inventories/prod/hosts.ini site.yml --check
```

### Limit to Specific Hosts
```bash
ansible-playbook -i inventories/prod/hosts.ini site.yml --limit app1
```

## Accessing Services

After deployment:

- **Grafana**: http://api.mek-lab.com:3000
- **Prometheus**: http://salome.mek-lab.com:9090
- **Loki**: http://api.mek-lab.com:3100

## Monitored Services

### Backend Server (api.mek-lab.com)
- **mek_lab_backend.service** - MEK-LAB Backend FastAPI
- **geoserver.service** - GeoServer
- **meklab-llm.service** - MEK-LAB LLM Agent

### Salome Server (salome.mek-lab.com)
- **salome-fastapi.service** - Salome FastAPI

## Service Management

### Backend Services
```bash
# Restart services
sudo systemctl restart mek_lab_backend.service
sudo systemctl restart geoserver.service
sudo systemctl restart meklab-llm.service

# Check status
sudo systemctl status mek_lab_backend.service
sudo systemctl status geoserver.service
sudo systemctl status meklab-llm.service

# View logs
sudo journalctl -u mek_lab_backend.service -f
sudo journalctl -u geoserver.service -f
sudo journalctl -u meklab-llm.service -f
```

### Salome Service
```bash
# Restart service
sudo systemctl restart salome-fastapi.service

# Check status
sudo systemctl status salome-fastapi.service

# View logs
sudo journalctl -u salome-fastapi.service -f
```

## Viewing Logs in Grafana

Go to http://api.mek-lab.com:3000 → Explore → Select "Loki (Salome)"

```logql
# Backend service
{job="meklab-backend"}

# GeoServer
{job="geoserver"}

# LLM service
{job="meklab-llm"}

# Salome service
{job="salome-fastapi"}

# All services
{job=~"meklab-backend|geoserver|meklab-llm|salome-fastapi"}
```

## Troubleshooting

### Check Service Status
```bash
ansible all -i inventories/prod/hosts.ini -m shell -a "systemctl status node_exporter" -b
```

### View Logs
```bash
ansible all -i inventories/prod/hosts.ini -m shell -a "journalctl -u node_exporter -n 50" -b
```

### Test Connectivity
```bash
ansible all -i inventories/prod/hosts.ini -m ping
```

## Development

### Adding New Roles

1. Create role structure:
```bash
ansible-galaxy init roles/new_role
```

2. Add tasks in `roles/new_role/tasks/main.yml`
3. Update `site.yml` to include the role
4. Add variables to `group_vars/all.yml`

### Testing

Test playbooks against sample inventory:
```bash
ansible-playbook -i inventories/sample/hosts.ini site.yml --check
```

## Security Considerations

- Keep `group_vars/secrets.yml` out of version control
- Use Ansible Vault for sensitive data in production
- Configure firewall rules for service ports
- Use SSH key authentication
- Regularly update component versions

