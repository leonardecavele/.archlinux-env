#!/usr/bin/env bash

# strict with errors
set -euo pipefail

# clone junest repository
if [ ! -d "$JUNEST_REPOSITORY" ]; then
  git clone https://github.com/fsquillace/junest.git "$JUNEST_REPOSITORY"
else
  echo "[INFO] ${RED}junest repository already exists: ${JUNEST_REPOSITORY}${RESET}"
  exit 0
fi

# setup junest
"$JUNEST" setup
"$JUNEST" -f -- sudo pacman --noconfirm -Syy
"$JUNEST" -f -- sudo pacman --noconfirm -Sy archlinux-keyring

echo "[INFO] ${GREEN}done${RESET}"
echo ""
