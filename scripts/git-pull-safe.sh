#!/usr/bin/env bash
set -euo pipefail

if flatpak ps | grep -q com.bambulab.BambuStudio; then
  echo "Zavri Bambu Studio pred git pull."
  exit 1
fi

exec git pull "$@"

