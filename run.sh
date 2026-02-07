#!/usr/bin/env bash

# strict with errors
set -euo pipefail

# colours
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export RESET='\033[0m'
export YELLOW='\033[0;33m'

# variables
export SCRIPT_DIRECTORY="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
export JUNEST_REPOSITORY="${JUNEST_REPOSITORY:-$HOME/.local/share/junest}"
export JUNEST="${JUNEST:-$JUNEST_REPOSITORY/bin/junest}"

# if user have sudo and pacman
if /usr/bin/sudo -n true >/dev/null 2>&1 && command -v pacman >/dev/null 2>&1; then
  echo "[INFO] ${GREEN}sudo + pacman available: installing on home${RESET}"
  bash "$SCRIPT_DIRECTORY/scripts/config.sh"
else
  echo "[INFO] ${RED}sudo and/or pacman not available: installing on junest${RESET}"
  bash "$SCRIPT_DIRECTORY/scripts/junest.sh"
  bash "$SCRIPT_DIRECTORY/scripts/config.sh"
fi

echo ""
echo "[INFO] ${GREEN}reloading shell${RESET}"
exec bash -l
