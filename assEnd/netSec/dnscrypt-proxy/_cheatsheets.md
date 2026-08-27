# dnscrypt-proxy — Cheatsheet

- Runs automatically as a systemd service once enabled — no manual launch needed
- `systemctl status dnscrypt-proxy` — check it's running
- `resolvectl status` or `cat /etc/resolv.conf` — confirm 127.0.0.1 is the active resolver
