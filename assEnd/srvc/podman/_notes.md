# podman — Notes (AI-assistant observations, not acted on)

This module sets `User = if cfg.rootless then "1000" else "root"` for the podman system service — hardcoding UID 1000 assumes that's your user's UID. If your actual user account isn't UID 1000, this service would try to run as the wrong user. Worth checking `id -u` against this before relying on rootless mode working as expected.
