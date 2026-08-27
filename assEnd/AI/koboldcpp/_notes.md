# koboldcpp — Notes (AI-assistant observations, not acted on)

This module only installs the koboldcpp binary — it doesn't run it as a background service. Right now you'd launch it manually each time. If you want it always running (e.g. so other tools/scripts can hit its API without you starting it first), that needs a systemd user service added on top of this — a good candidate for the scripting work you mentioned you're already doing.
