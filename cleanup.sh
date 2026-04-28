#!/usr/bin/env bash
# Undo install.sh: remove ~/.vimrc and ~/.vim symlinks when they point at this repo (restores Vim defaults for your user).

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"
BASE_PATH="$(pwd)"

### Logging

msg() {
  printf '%b\n' "$1" >&2
}

warn() {
  msg "\33[33m[!]\33[0m ${1}"
}

error() {
  msg "\33[31m[✘]\33[0m ${1}"
  exit 1
}

show_help() {
  msg "Usage: $(basename "$0") [options]"
  msg "  Remove ~/.vimrc and ~/.vim symlinks created by install.sh (only if they target this repo)."
  msg ""
  msg "Options:"
  msg "  --plugged, -p    Also delete ${BASE_PATH}/plugged (vim-plug clones inside this repo)."
  msg "  -h, --help       Show this help."
}

# Remove symlink only when readlink matches expected (same targets install.sh uses).
remove_repo_symlink() {
  local linkpath="$1"
  local expected_target="$2"
  local label="$3"

  if [ ! -L "$linkpath" ]; then
    if [ -e "$linkpath" ]; then
      warn "${label}: \"${linkpath}\" exists but is not a symlink — left unchanged."
    else
      msg "${label}: \"${linkpath}\" is absent — nothing to remove."
    fi
    return 0
  fi

  if [ "$(readlink "$linkpath")" != "$expected_target" ]; then
    warn "${label}: \"${linkpath}\" points elsewhere — left unchanged."
    return 0
  fi

  rm "$linkpath"
  msg "${label}: removed symlink \"${linkpath}\" -> \"${expected_target}\""
}

remove_plugged_dir() {
  local d="$BASE_PATH/plugged"
  if [ ! -d "$d" ]; then
    msg "plugged: no directory at \"${d}\" — skipping."
    return 0
  fi
  rm -rf "$d"
  msg "plugged: removed \"${d}\""
}

#### main

REMOVE_PLUGGED=0
case "${1:-}" in
  -h | --help)
    show_help
    exit 0
    ;;
  --plugged | -p)
    REMOVE_PLUGGED=1
    ;;
  '')
    ;;
  *)
    error "Unknown option: $1 (try --help)"
    ;;
esac

if [ "${2:-}" != '' ]; then
  error "Unexpected argument: $2 (try --help)"
fi

msg "Cleanup (repo: ${BASE_PATH})"

remove_repo_symlink "$HOME/.vimrc" "$BASE_PATH/vimrc" "~/.vimrc"
remove_repo_symlink "$HOME/.vim" "$BASE_PATH" "~/.vim"

if [ "$REMOVE_PLUGGED" -eq 1 ]; then
  remove_plugged_dir
fi

msg "Done. Vim will use built-in defaults until you configure ~/.vimrc again."
