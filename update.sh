#!/usr/bin/env bash
# Refresh vim-plug and external assets

cd "$(dirname "${BASH_SOURCE[0]}")"
BASE_PATH="$(pwd)"

msg() {
  printf '%b\n' "$1" >&2
}

success() {
  if [ "$ret" -eq '0' ]; then
    msg "\33[32m[✔]\33[0m ${1}${2}"
  fi
}

#### main

msg "Upgrade 'vim-plug'"
vim +PlugUpgrade +qall 1>/dev/null 2>&1

msg "Update Vim plugins"
vim +PlugUpdate +qall 1>/dev/null 2>&1
ret=$?

success "Vim configuration updated. Run :CocUpdate in Vim to refresh LSP extensions."

