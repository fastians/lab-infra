# Infrastructure Automation

A professional-grade infrastructure-as-code (IaC) project designed to automate the provisioning, configuration, and monitoring of high-performance lab environments. This repository serves as a showcase for modern DevOps practices, focusing on scalability, security, and observable systems.

## One-by-one setup (manual order)

Run by server name, one at a time; test, then the next:

```bash
./provision monitoring-server
./provision salome-server
./provision backend-server
```

Each command runs `site.yml` limited to that host only.

## 🌟 Key Features

- **Automated Provisioning**: One-touch deployment for complex server clusters using Ansible.
- **Microservices Orchestration**: Automated management of multiple FastAPI and AI-driven services.
- **Enterprise Monitoring**: Full observability stack with **Prometheus**, **Grafana**, and **Loki** for real-time performance tracking and log aggregation.
- **Secure by Design**: Best-practices implementation of secret management, automated SSL termination (Certbot), and secure Nginx reverse proxying.
- **Scalable Architecture**: Modular design that supports multi-environment deployments (Production, Testing, Development).

## 🛠️ Technology Stack

- **Infrastructure**: Ansible, Linux (Ubuntu/Debian)
- **Networking**: Nginx, Cloudflare, SSL/TLS
- **Monitoring**: Prometheus, Grafana, Loki, Promtail
- **Application**: Python (FastAPI), PostgreSQL
- **Security**: SSH Key Management, Ansible Vault (Reference), Secret Scan Protection

## 📈 System Impact

This project transforms manual server setup into a reliable, repeatable process. It ensures:
- **Zero-Downtime Deployments**: Scripted rolling updates for applications.
- **Centralized Visibility**: Unified dashboard for all server health metrics and logs.
- **Developer Efficiency**: Simplified environment replication and management.

---

*This project is used to manage the infrastructure, providing high availability for AI agents and engineering platforms.*
