{ pkgs, ... }:
{
  # Automatically deletes anything in ~/.cache untouched for 30+ days,
  # once a week. Nothing to run by hand — this is a background systemd
  # timer, same mechanism NixOS itself uses for its own scheduled jobs.
  systemd.user.services.cache-cleanup = {
    Unit.Description = "Delete stale files in ~/.cache";
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.findutils}/bin/find %h/.cache -type f -atime +30 -delete";
    };
  };

  systemd.user.timers.cache-cleanup = {
    Timer = {
      OnCalendar = "weekly";
      Persistent = true; # if the machine was off when it should've run, run it on next boot instead of skipping
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
