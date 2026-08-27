{ config, lib, username, ... }:

# Active configuration for greeter.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  services.greetd.enable = true;
  # autoLoginUser defaults to `username` (passed in as a special module arg)
  # unless overridden here.
}
