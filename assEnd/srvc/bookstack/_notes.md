# bookstack — Notes (AI-assistant observations, not acted on)

This module configures the web server and PHP side, but has no database module of its own — DB_HOST/DB_DATABASE/DB_USERNAME in the settings option point at a database that doesn't exist yet in this dump. Bookstack won't actually come up until a MySQL/MariaDB or Postgres service is added and configured to match.
