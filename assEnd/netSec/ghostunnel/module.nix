{ config, lib, ... }:

# Active configuration for ghostunnel.
# config.nix declares what's possible, this file decides what ovrOS uses now.
#
# ghostunnel needs at least one named "server" tunnel defined, and every
# server needs at least one access-control rule set (allowAll, allowCN,
# allowOU, allowDNS, allowURI, or disableAuthentication) or NixOS will
# refuse to build. The "example" server below is a placeholder so this
# evaluates out of the box -- swap allowAll for a real rule before you
# actually expose anything with it.
{
  services.ghostunnel.enable = true;

  services.ghostunnel.servers.example = {
    listen = "127.0.0.1:8443";
    target = "127.0.0.1:8080";
    allowAll = true; # placeholder -- replace with allowCN/allowDNS/etc for real use
  };
}
