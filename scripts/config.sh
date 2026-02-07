#!/usr/bin/env bash

# strict with errors
set -euo pipefail

# pacman package list
pkgs=(
  neovim
  base-devel
  macchina
  which
  tree
  tree-sitter-cli
  openssh
  nodejs
  npm
  curl
  git
  tar
  gzip
  wget
)

# npm package list
npms=(
  pyright
)

# detect mode to set runner
if /usr/bin/sudo -n true >/dev/null 2>&1 && command -v pacman >/dev/null 2>&1; then
  echo "[INFO] ${GREEN}mode: host${RESET}"
  RUN=()
else
  echo "[INFO] ${GREEN}mode: junest${RESET}"
  if [ ! -x "$JUNEST" ]; then
    echo "[ERROR] ${RED}junest not found at: $JUNEST${RESET}"
    exit 1
  fi
  RUN=("$JUNEST" -n)
fi

# update + install pkgs
"${RUN[@]}" sudo pacman -Syu --noconfirm
"${RUN[@]}" sudo pacman -S --noconfirm --needed "${pkgs[@]}"

# update + install npms trying without sudo first
if ! "${RUN[@]}" npm i -g --no-fund --no-audit "${npms[@]}"; then
  "${RUN[@]}" sudo npm i -g --no-fund --no-audit "${npms[@]}"
fi

# link config to home
mkdir -p "$HOME/.config"
ln -svf "$SCRIPT_DIRECTORY/kitty" "$HOME/.config/" || true
ln -svf "$SCRIPT_DIRECTORY/nvim" "$HOME/.config/" || true
ln -svf "$SCRIPT_DIRECTORY/macchina" "$HOME/.config/" || true
ln -svf "$SCRIPT_DIRECTORY/.bashrc" "$HOME/.bashrc" || true

# vim-plug to home
data_home="${XDG_DATA_HOME:-$HOME/.local/share}"
plug_path="$data_home/nvim/site/autoload/plug.vim"
if [ ! -f "$plug_path" ]; then
  curl -sfLo "$plug_path" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim >/dev/null
fi

echo ""
echo "[INFO] ${GREEN}done${RESET}"
echo "[info] ${YELLOW}open nvim and run :PlugInstall${RESET}"
