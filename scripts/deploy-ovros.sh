#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

usage() {
  cat <<USAGE
Usage:
  $0 install <hostname> [target-root]
  $0 switch <hostname>
  $0 check <hostname>

Examples:
  $0 install lilOSoul /mnt
  $0 switch lilOSoul
  $0 check lilOSoul
USAGE
}

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "Missing required command: $1" >&2
    exit 1
  }
}

require_cmd nix

mode="${1:-}"
host="${2:-}"

if [[ -z "$mode" || -z "$host" ]]; then
  usage
  exit 1
fi

cd "$ROOT_DIR"

case "$mode" in
  install)
    target_root="${3:-/mnt}"
    hardware_file="hosts/${host}/hardware-configuration.nix"

    if [[ ! -f "$hardware_file" ]]; then
      echo "Missing ${hardware_file}. Create hosts/${host}/ first." >&2
      exit 1
    fi

    if grep -q "PLACEHOLDER" "$hardware_file"; then
      echo "${hardware_file} is still placeholder content." >&2
      echo "Generate and copy a real hardware config first:" >&2
      echo "  sudo nixos-generate-config --root ${target_root}" >&2
      echo "  sudo cp ${target_root}/etc/nixos/hardware-configuration.nix ${hardware_file}" >&2
      exit 1
    fi

    sudo nixos-install --flake ".#${host}"
    ;;
  switch)
    sudo nixos-rebuild switch --flake ".#${host}"
    ;;
  check)
    nix flake check --no-build
    nix eval ".#nixosConfigurations.${host}.config.system.build.toplevel.drvPath" >/dev/null
    echo "Flake check passed for host ${host}."
    ;;
  *)
    usage
    exit 1
    ;;
esac
