# detect junest
if is_junest; then
  RUN=()
else
  RUN=("$JUNEST" -n)

# detect package manager
if is_pacman; then
  source "$SCRIPT_DIRECTORY/packages/pacman.sh" -i
elif is_dnf; then
  source "$SCRIPT_DIRECTORY/packages/dnf.sh" -i
elif is_apt; then
  source "$SCRIPT_DIRECTORY/packages/apt.sh" -i
fi

# install npm packages
log_info "$0" "installing npm packages"

missing_npms=()
for pkg in "${npms[@]}"; do
  if ! "${RUN[@]}" npm -g ls "$pkg" --depth=0 >/dev/null 2>&1; then
    missing_npms+=("$pkg")
  fi
done
  
if [ "${#missing_npms[@]}" -eq 0 ]; then
  echo "nothing to do"
else
  mkdir -p ~/.npm-global
  "${RUN[@]}" npm config set prefix "$npm_directory"
  "${RUN[@]}" npm i -g --no-fund --no-audit "${missing_npms[@]}"
  fi
fi

log_info "$0" "successfully installed npm packages"

# install cargo packages
log_info "$0" "installing cargo packages"

missing_cargos=()
for pkg in "${cargos[@]}"; do
  if ! "${RUN[@]}" command -v "$pkg" >/dev/null 2>&1; then
    missing_cargos+=("$pkg")
  fi
done
if [ "${#missing_cargos[@]}" -eq 0 ]; then
  echo "nothing to do"
else
  "${RUN[@]}" cargo install "${missing_cargos[@]}"
fi

log_info "$0" "successfully installed cargo packages"
