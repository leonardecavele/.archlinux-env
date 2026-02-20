# detect junest
if is_junest; then
  RUN=()
else
  RUN=("$JUNEST" -n)
fi

# update cargo packages
log_info "$0" "updating cargo packages"

for pkg in "${cargos[@]}"; do
  # cargo-install-update met à jour les binaires installés via cargo install
  # si tu ne l'as pas, ça va juste skip sans casser le script
  "${RUN[@]}" cargo install-update -a >/dev/null 2>&1 || true
  break
done

log_info "$0" "successfully updated cargo packages"

# update npm packages
log_info "$0" "updating npm packages"

npm config set prefix "$npm_directory"
"${RUN[@]}" sudo npm update -g "${npms[@]}" >/dev/null 2>&1 || true

log_info "$0" "successfully updated npm packages"

# detect package manager
if is_pacman; then
  source "$SCRIPT_DIRECTORY/packages/pacman.sh" -u
elif is_dnf; then
  source "$SCRIPT_DIRECTORY/packages/dnf.sh" -u
elif is_apt; then
  source "$SCRIPT_DIRECTORY/packages/apt.sh" -u
fi
