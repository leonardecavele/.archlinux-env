if [ "${1-}" = "-i" ] ; then
  # install apt packages
  log_info "$0" "installing apt packages"

  sudo apt-get update -y </dev/null
  sudo apt-get upgrade -y </dev/null
  sudo apt-get install -y "${apt_pkgs[@]}" </dev/null

  log_info "$0" "successfully installed apt packages"

elif [ "${1-}" = "-u" ] ; then
  # update apt packages
  log_info "$0" "updating apt packages"

  sudo apt-get update -y </dev/null || true
  sudo apt-get upgrade -y </dev/null || true

  log_info "$0" "successfully updated apt packages"

elif [ "${1-}" = "-d" ] ; then
  # delete apt packages
  log_info "$0" "deleting apt packages"

  for pkg in "${apt_pkgs[@]}"; do
    if dpkg -s "$pkg" >/dev/null 2>&1; then
      if ! sudo apt-get purge -y "$pkg" </dev/null; then
        log_info "$0" "skipped (blocked by deps?): $pkg"
      fi
    fi
  done
  sudo apt-get autoremove -y </dev/null || true
  sudo apt-get clean </dev/null || true

  log_info "$0" "successfully deleted apt packages"
fi
