# Neuralwire Status Page (`status`)

[![Live Status](https://img.shields.io/badge/Status-Operational-00e599?style=flat-square)](https://status.neuralwire.info)
[![Canonical Site](https://img.shields.io/badge/Site-neuralwire.info-00e599?style=flat-square)](https://neuralwire.info)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square)](LICENSE)

Official uptime monitoring, latency tracking, and incident response infrastructure for [Neuralwire](https://neuralwire.info), powered by [Uptime Kuma](https://uptime.kuma.pet/).

---

## 🌐 Production Architecture & Endpoints

| Target Service | Monitored Endpoint | Check Type | Interval |
|---|---|---|---|
| **Web Frontend** | `https://neuralwire.info` | HTTPS (200 OK) | 60s |
| **Backend API Health** | `https://neuralwire.info/api/health` | HTTPS (200 OK + JSON Schema) | 60s |
| **RSS / Syndicate Feed** | `https://neuralwire.info/feed.xml` | HTTPS (200 OK + XML Header) | 120s |
| **SSL / TLS Certificate** | `neuralwire.info` | TLS Expiry Alert (< 14 Days) | 24h |

---

## 🚀 Quick Start (Docker Compose)

### 1. Prerequisites
- Docker Engine 24.0+
- Docker Compose v2+

### 2. Setup & Boot
```bash
# Clone the repository
git clone git@github.com:neuralwire-media/status.git
cd status

# Copy environment template
cp .env.example .env

# Start Uptime Kuma in background
docker compose up -d
```

Access the web dashboard and public status page at `http://localhost:3001`.

---

## 🔒 Domain & Reverse Proxy Setup (`status.neuralwire.info`)

To expose the status page publicly on `status.neuralwire.info`:

### Option A: Cloudflare Tunnel (Zero-Open Ports / Recommended)
1. In Cloudflare Zero Trust Dashboard, create a new Tunnel pointing to:
   - **Service Type**: `HTTP`
   - **URL**: `localhost:3001`
   - **Hostname**: `status.neuralwire.info`
2. No router port forwarding or firewall adjustments required.

### Option B: Caddy / Nginx Reverse Proxy
```caddy
status.neuralwire.info {
    reverse_proxy 127.0.0.1:3001
}
```

---

## 🔔 Recommended Alert Integrations

Uptime Kuma supports direct webhook integrations:
- **Telegram**: Create a Telegram bot via `@BotFather` and add your Chat ID to receive instant downtime alerts.
- **Discord**: Create a Webhook URL in your announcement/ops channel.
- **Email (SMTP)**: Configure transactional SMTP credentials.

---

## 💾 Backup & Restore

```bash
# Run manual backup
./scripts/backup.sh

# Automatic cron (e.g. daily at 02:00 AM)
0 2 * * * cd /path/to/status && ./scripts/backup.sh >> /var/log/status-backup.log 2>&1
```

---

## 📄 License
This project is open-source software licensed under the [MIT License](LICENSE).
