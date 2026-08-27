# cloudflared — Cheatsheet

- Runs as a background systemd service once enabled — no manual launch needed
- `systemctl status cloudflared-tunnel-<id>` — check tunnel status
- `journalctl -u cloudflared-tunnel-<id>` — view tunnel logs
