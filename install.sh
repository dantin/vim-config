#!/usr/bin/env bash
# Install this repo as ~/.vimrc + ~/.vim and run vim-plug (CoC/LSP need Node separately; see docs/SPEC.md).

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"
BASE_PATH="$(pwd)"

VIM_BIN="${VIM_BIN:-vim}"
# Set INSTALL_VERBOSE=1 to show curl and vim output during install.
install_verbose() {
  [ "${INSTALL_VERBOSE:-0}" = 1 ] || [ "${INSTALL_VERBOSE:-0}" = true ]
}

### Logging

msg() {
  printf '%b\n' "$1" >&2
}

success() {
  if [ "${ret:-1}" -eq 0 ]; then
    msg "\33[32m[✔]\33[0m ${1}${2:-}"
  fi
}

error() {
  msg "\33[31m[✘]\33[0m ${1}${2:-}"
  exit 1
}

require_cmd() {
  local name="$1"
  if ! command -v "$name" >/dev/null 2>&1; then
    error "Missing '${name}' on PATH (required for this installer)."
  fi
}

download_resource() {
  local local_path="$1"
  local remote_url="$2"

  if install_verbose; then
    curl -fLo "$local_path" --create-dirs "$remote_url"
  else
    curl -fLo "$local_path" --create-dirs "$remote_url" &>/dev/null
  fi

  ret=$?
  if [ "$ret" -ne 0 ]; then
    error "Failed to download '${remote_url}' (curl exit ${ret})"
  fi
  success "Download complete"
}

# Symlink linkpath -> target (repo file or directory). Refuses regular files/dirs at linkpath.
ensure_repo_symlink() {
  local target="$1"
  local linkpath="$2"
  local label="$3"

  if [ -e "$linkpath" ] && [ ! -L "$linkpath" ]; then
    error "${label}: path exists and is not a symlink — back it up or remove \"${linkpath}\" and re-run."
  fi

  if [ -L "$linkpath" ]; then
    if [ "$(readlink "$linkpath")" = "$target" ] && [ -e "$linkpath" ]; then
      msg "${label}: already linked -> ${target}"
      return 0
    fi
    msg "${label}: updating symlink -> ${target}"
    ln -sfn "$target" "$linkpath" || error "Failed to update symlink \"${linkpath}\""
    return 0
  fi

  msg "Create symbolic link \"${linkpath}\" -> \"${target}\""
  ln -s "$target" "$linkpath" || error "Failed to create symlink \"${linkpath}\""
}

show_help() {
  msg "Usage: $(basename "$0") [options]"
  msg "  Link this repo to ~/.vimrc and ~/.vim, install vim-plug if needed, run :PlugInstall."
  msg ""
  msg "Environment:"
  msg "  VIM_BIN       Vim binary (default: vim); Neovim supported."
  msg "  INSTALL_VERBOSE=1   Show curl and vim output"
}

# Non-interactive PlugInstall must avoid: (1) -- More -- / hit-ENTER with output redirected;
# (2) loading coc/LSP/UI maps without a TTY. install.sh sets VIM_PLUG_BOOTSTRAP for a
# minimal vimrc; we also set nomore, high cmdheight, --not-a-term (Vim) or --headless (nvim),
# and attach stdin to /dev/null so nothing waits for keys.
run_vim_plug_install() {
  export VIM_PLUG_BOOTSTRAP=1
  local -a vim_args=(
    -N
    -i NONE
    --cmd 'set nomore'
    --cmd 'set shortmess=atTI'
    --cmd 'set cmdheight=99'
  )
  case $(basename "$VIM_BIN") in
    nvim)
      vim_args+=(--headless)
      ;;
    *)
      vim_args+=(--not-a-term)
      ;;
  esac

  set +e
  if install_verbose; then
    "$VIM_BIN" "${vim_args[@]}" +PlugInstall +qa! </dev/null
  else
    "$VIM_BIN" "${vim_args[@]}" +PlugInstall +qa! &>/dev/null </dev/null
  fi
  ret=$?
  set -e
  unset VIM_PLUG_BOOTSTRAP
}

#### main

case "${1:-}" in
  -h | --help)
    show_help
    exit 0
    ;;
esac

require_cmd curl
require_cmd "$VIM_BIN"

# .vimrc
ensure_repo_symlink "$BASE_PATH/vimrc" "$HOME/.vimrc" "~/.vimrc"

# ~/.vim → repo root (runtimepath expects this layout)
ensure_repo_symlink "$BASE_PATH" "$HOME/.vim" "~/.vim"

# vim-plug
if [ ! -e "$BASE_PATH/autoload/plug.vim" ]; then
  msg "Install 'vim-plug'"
  download_resource "$BASE_PATH/autoload/plug.vim" "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
fi

msg "Install Vim plugins (${VIM_BIN}: vim-plug, coc, fzf, …)"
run_vim_plug_install
if [ "$ret" -ne 0 ]; then
  error "PlugInstall failed (${VIM_BIN} exit ${ret}). Try INSTALL_VERBOSE=1 $(basename "$0"). Is '${VIM_BIN}' on PATH and working?"
fi

success "Vim config bootstrap complete. If you use CoC, run :CocUpdate inside Vim after install."
