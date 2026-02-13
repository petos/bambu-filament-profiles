#!/usr/bin/env bash
set -euo pipefail

#FILAMENT_DIR="$HOME/.var/app/com.bambulab.BambuStudio/data/bambu-studio/storage/user/filament"
FILAMENT_DIR="$(pwd)"

echo "Kontrola otevrenych souboru"
if ! flatpak ps | grep -q com.bambulab.BambuStudio; then
  echo "Bambu Studio nebezi - merge neni zablokovan."
  exit 0
fi
echo "Bambu studio bezi, kontroluji otevrene soubory"
if command -v lsof >/dev/null 2>&1; then
  if lsof +D "$FILAMENT_DIR" 2>/dev/null | grep -q BambuStudio; then
    echo "Bambu Studio ma otevrene filament soubory."
    echo "   Zavri ho pred 'git pull'."
    exit 1
  fi
else
  # fallback bez lsof (pomalejsi, ale funkční)
  for pid in /proc/[0-9]*; do
    if ls "$pid/fd" 2>/dev/null | while read -r fd; do
         readlink "$pid/fd/$fd" 2>/dev/null
       done | grep -q "$FILAMENT_DIR"; then
      echo "Proces $(basename "$pid") ma otevrene filament soubory."
      exit 1
    fi
  done
fi

exec git pull "$@"
