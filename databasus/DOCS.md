# Databasus

Self-hosted database backup manager with scheduling, restore verification, retention policies, and multi-storage support. Supports PostgreSQL (12–18), MySQL (5.7, 8, 9), MariaDB (10–12), and MongoDB (4.2+).

Upstream project: [databasus/databasus](https://github.com/databasus/databasus)  
Add-on image: [ruepp/hassio-image-databasus](https://hub.docker.com/r/ruepp/hassio-image-databasus)

---

## First-time setup

1. Start the add-on.
2. Wait ~30–60 seconds for the internal database to initialise.
3. Click **OPEN WEB UI** on the add-on page to open the dashboard in a new browser tab, or navigate directly to `http://homeassistant.local:4005`.
4. Create your admin account on the first-run screen.
5. Add your databases, configure storage destinations, and set backup schedules — all from within the Databasus web UI.

---

## Data persistence

All Databasus configuration, credentials, and backup metadata are persisted automatically by Home Assistant across restarts, updates, and reinstalls. Home Assistant backups include this data automatically.

---

## External (direct port) access

By default the port is not exposed to your network. To enable direct access:

1. Open the add-on **Configuration** tab.
2. Under **Network**, set the host port for `4005/tcp` (e.g. `4005`).
3. Click **Save** and restart the add-on.
4. Access Databasus at `http://homeassistant.local:4005`.

---

## Managing databases

All database connections, backup schedules, storage destinations (S3, Google Drive, FTP, local, etc.), notifications (Slack, Discord, Telegram, email), and retention policies are configured entirely within the Databasus web UI. No Home Assistant configuration options are required.
