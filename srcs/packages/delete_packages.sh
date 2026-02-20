# detect junest
if is_junest; then
  RUN=()
else
  RUN=("$JUNEST" -n)

# delete cargo packages
log_info "$0" "deleting cargo packages"

for pkg in "${cargos[@]}"; do
  "${RUN[@]}" cargo uninstall "$pkg" >/dev/null 2>&1 || true
done

log_info "$0" "successfully deleted cargo packages"

# delete npm packages
log_info "$0" "deleting npm packages"

npm config set prefix "$npm_directory"
"${RUN[@]}" sudo npm uninstall -g "${npms[@]}"

log_info "$0" "successfully deleted npm packages"

# detect package manager
if is_pacman; then
  source "$SCRIPT_DIRECTORY/packages/pacman.sh" -d
elif is_dnf; then
  source "$SCRIPT_DIRECTORY/packages/dnf.sh" -d
elif is_apt; then
  source "$SCRIPT_DIRECTORY/packages/apt.sh" -d
fi
