{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    curl
    wget
    git
    vim
    htop
    jq
    unzip
    zip
    pciutils
    usbutils
  ];
}
