{
  imports = [
    ../netSec/cloudflared
    ../netSec/dnscrypt-proxy
    ../netSec/ghostunnel
    ../netSec/nntp-proxy
    ../netSec/security
    ../netSec/shadowsocks
  ];

  # ../netSec/firewall.nix is intentionally not imported -- it was a
  # verbatim copy of NixOS's own built-in firewall module, which is always
  # present. Importing a second copy would conflict with it. NixOS's real
  # firewall is configured normally via `networking.firewall.*` elsewhere.
  #
  # ../netSec/networkmanager.nix is skipped for the same reason -- a
  # verbatim copy of the built-in NetworkManager module. Turn NetworkManager
  # on normally via `networking.networkmanager.enable = true;`.
  #
  # ../netSec/ghost-tunnel.nix (the simpler single-tunnel version) was
  # scrapped -- ghostunnel.nix (the fuller multi-server version) replaces it.
  #
  # Import path typos from the original dump are also fixed here:
  # `cloudfared.nix` -> `cloudflared/`, `dnscrypt-proxy.net` -> `dnscrypt-proxy/`.
}
