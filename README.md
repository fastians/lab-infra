# Infrastructure Automation

A professional-grade infrastructure-as-code (IaC) project designed to automate the provisioning, configuration, and monitoring of high-performance lab environments. This repository serves as a showcase for modern DevOps practices, focusing on scalability, security, and observable systems.

## One-by-one setup (manual order)

Run by server name, one at a time; test, then the next:

```bash
./provision monitoring-server   # Monitor (Prometheus, Grafana, Loki, Alertmanager, Blackbox)
./provision backend-server      # Backend: one machine, three FastAPI apps (backendserver, geoserver, llmserver)
./provision salome-server      # Salome app server
```

Or use short names to run provision playbooks: `./provision monitor`, `./provision backend`, `./provision salome`. Use `./provision verify` to check all servers; `./provision help` for more.

## 🌟 Key Features

- **Automated Provisioning**: One-touch deployment for server clusters using Ansible (`./provision`, `site.yml`).
- **Microservices Orchestration**: Backend server runs three FastAPI apps (ports 8000, 8001, 8002); Salome runs one (8000).
- **Enterprise Monitoring**: Dedicated monitor server with **Prometheus**, **Grafana**, **Loki**, **Alertmanager**, **Blackbox Exporter**; **Promtail** and **Node Exporter** on app servers.
- **Secure by Design**: Secret management, automated SSL (Certbot), Nginx reverse proxy.
- **Scalable Architecture**: Modular roles; multi-environment inventories (prod, sample).

## 🛠️ Technology Stack

- **Infrastructure**: Ansible, Linux (Ubuntu/Debian)
- **Networking**: Nginx, Certbot, SSL/TLS
- **Monitoring**: Prometheus, Grafana, Loki, Promtail, Alertmanager, Blackbox Exporter, Node Exporter
- **Application**: Python (FastAPI), PostgreSQL
- **Security**: SSH key management, Ansible Vault, secret scan protection

## 📈 System Impact

- **Repeatable Setup**: Scripted server and app deployment.
- **Centralized Visibility**: One dashboard for metrics and logs (Grafana → Prometheus/Loki).
- **Developer Efficiency**: Simple replication and management via `./provision` and `./deploy`.

---

*For AI/automation context (structure, commands, service names), see [CLAUDE.md](CLAUDE.md). For operations and architecture, see `docs/`.*
