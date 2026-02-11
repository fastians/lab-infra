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

- `monitoring`: Servers running Prometheus, Grafana, and Loki
- `app`: Application servers with Node Exporter and Promtail

Example:
```ini
[monitoring]
monitor ansible_host=MONITOR_SERVER_IP ansible_user=mateen_fastians

[app]
app1 ansible_host=APP_SERVER_IP ansible_user=mateen_fastians
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

- **Prometheus**: http://monitor-server:9090
- **Grafana**: http://monitor-server:3000
- **Node Exporter**: http://any-server:9100/metrics
- **FastAPI Metrics**: http://app-server:8000/metrics

## Monitoring Targets

The Prometheus configuration automatically discovers and monitors:

1. **Prometheus itself** (localhost:9090)
2. **All Node Exporters** (port 9100) on app and monitoring servers
3. **FastAPI applications** (port 8000/metrics) on app servers

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

