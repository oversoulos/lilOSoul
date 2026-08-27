{ config, pkgs, lib, ... }:

let
  cfg = config.services.your-spotify;
in

{
  options.services.your-spotify = {
    enable = lib.mkEnableOption "Your-Spotify stats dashboard";
    package = lib.mkPackageOption pkgs "your_spotify" { };
    port = lib.mkOption {
      type = lib.types.port;
      default = 3000;
      description = "Web UI port";
    };
    spotifySecretFile = lib.mkOption {
      type = lib.types.path;
      description = "File containing Spotify API secret";
    };
    spotifyPublic = lib.mkOption {
      type = lib.types.str;
      description = "Spotify client ID";
    };
    clientEndpoint = lib.mkOption {
      type = lib.types.str;
      description = "Client endpoint URL";
    };
    apiEndpoint = lib.mkOption {
      type = lib.types.str;
      default = "http://localhost:3000";
      description = "API endpoint";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    systemd.services.your-spotify = {
      description = "Your-Spotify Stats Dashboard";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${cfg.package}/bin/your_spotify";
        Environment = [
          "CLIENT_ENDPOINT=${cfg.clientEndpoint}"
          "API_ENDPOINT=${cfg.apiEndpoint}"
          "PORT=${toString cfg.port}"
          "SPOTIFY_PUBLIC=${cfg.spotifyPublic}"
          "SPOTIFY_SECRET_FILE=${cfg.spotifySecretFile}"
        ];
        Restart = "always";
        DynamicUser = true;
        StateDirectory = "your-spotify";
      };
    };
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: xdg.desktopEntries
  # overrides, extraConfig files, or app-specific environment vars.
}
