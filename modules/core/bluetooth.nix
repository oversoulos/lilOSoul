{ ... }:
{
  # Bluetooth engine — without this, the Bluetooth dashboard (blueman, at
  # user level) has nothing to actually control.
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}
