# Infrastructure Management

Automated infrastructure and application management using Ansible.

## 🏗️ Architecture Overview

The system consists of two primary roles:

1.  **Backend Server (`api.mek-lab.com`)**: Hosts the monitoring stack (Prometheus, Loki, Grafana) and core Python applications (`backendserver`, `geoserver`, `llmserver`).
2.  **Salome Server (`salome.mek-lab.com`)**: Hosts the public-facing application and ships logs back to the backend server.

Detailed technical overview can be found in [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md).

## 🚀 Quick Reference

### Core Operations
| Task | Command |
|------|---------|
| **Deploy App** | `./deploy <service> <branch>` |
| **Verify Health** | `./provision verify` |
| **Sync Scripts** | `./sync` |
| **Provision Server** | `./provision <salome|backend>` |

### Common Services
| Service | Name | Port |
|---------|------|------|
| Backend App | `backendserver` | 8000 |
| Geo Server | `geoserver` | 8001 |
| LLM Agent | `llmserver` | 8002 |
| Grafana | `grafana` | 3000 |

## 📚 Documentation Index

For detailed guides, please refer to:

- 🏗️ **[Architecture Overview](docs/ARCHITECTURE.md)**: Technical design and data flows.
- 🚀 **[Operations Guide](docs/OPERATIONS.md)**: Provisioning, deployment, and maintenance.
- 🔐 **[Configuration & Secrets](docs/CONFIGURATION.md)**: Managing variables, env files, and security.

## 🛠️ Development

### Prerequisites
- Ansible 2.9+
- Python 3.6+
- SSH access to target servers

### Setup
1. Configure inventory in `inventories/prod/hosts.ini`.
2. Configure secrets in `group_vars/secrets.yml` (using Ansible Vault).
3. Run `ansible-playbook core_setup.yml` for initial provisioning.
