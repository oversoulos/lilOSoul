{ config, lib, ... }:

# Active configuration for security (the netSec toolkit bundle).
# Note the real option path is `molecular.security`, not `netSec.security`
# -- see this module's _notes.md for why.
{
  molecular.security.enable = true;
  # molecular.security.tailscale = true;  # optional, overlaps with atomic/sys/tailscale
  # molecular.security.privoxy = true;    # optional
}
