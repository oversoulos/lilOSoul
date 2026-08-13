#!/usr/bin/env bash
set -euo pipefail

# OvrOS bootstrap — always pulls the CURRENT version of the repo from
# GitHub, so any edits you've pushed since last time are automatically
# included. Nothing about this script needs to change when the repo
# changes.

REPO_SSH="git@github.com:oversoulos/lilOSoul.git"
DEST="OvrOS"
HOST="lilOSoul"

usage() {
  cat <<USAGE
Usage:
  $0 install [target-root]   # fresh install from a live ISO (default target-root: /mnt)
  $0 switch                  # apply config on an already-installed system
  $0 check                   # just verify the flake, no changes made
USAGE
}

mode="${1:-}"
if [[ -z "$mode" ]]; then
  usage
  exit 1
fi

if [[ -d "$DEST" ]]; then
  echo "Existing ./$DEST found — pulling latest changes instead of re-cloning."
  git -C "$DEST" pull
else
  git clone "$REPO_SSH" "$DEST"
fi

cd "$DEST"

case "$mode" in
  install)
    target_root="${2:-/mnt}"
    sudo ./scripts/deploy-ovros.sh install "$HOST" "$target_root"
    ;;
  switch)
    sudo ./scripts/deploy-ovros.sh switch "$HOST"
    ;;
  check)
    ./scripts/deploy-ovros.sh check "$HOST"
    ;;
  *)
    usage
    exit 1
    ;;
esac