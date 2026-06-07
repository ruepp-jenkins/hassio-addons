# Changelog

## 1.1.0

- Removed Ingress embedding — Databasus does not render correctly inside Home Assistant's Ingress iframe
- Added an "OPEN WEB UI" button that opens the dashboard in its own browser tab at `http://homeassistant.local:4005`
- Port 4005 is now published on the host by default so the Web UI button always resolves a valid URL

## 1.0.0

- Initial release
- Uses pre-built image `ruepp/hassio-image-databasus:latest` — no build step on the Home Assistant server
- Ingress support for in-dashboard access
- Optional direct port access on 4005
- Data persisted across restarts and updates by Home Assistant
