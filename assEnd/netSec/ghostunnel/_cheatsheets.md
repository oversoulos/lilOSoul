# ghostunnel — Cheatsheet

- Runs as one systemd service per named server: `systemctl status ghostunnel-server-<name>`
- `journalctl -u ghostunnel-server-<name>` — view logs for a specific tunnel
- Define new tunnels under `services.ghostunnel.servers.<name>` in module.nix
