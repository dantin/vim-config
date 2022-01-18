#!/usr/bin/env bash
# sudo yum install -y python-devel python3-devel

cd $(dirname "${BASH_SOURCE[0]}")
BASE_PATH="$(pwd)"

msg() {
    printf '%b\n' "$1" >&2
}

success() {
    if [ "$ret" -eq '0'  ]; then
        msg "\33[32m[✔]\33[0m ${1}${2}"
    fi
}

error() {
    msg "\33[31m[✘]\33[0m ${1}${2}"
    exit 1
}

download_resource() {
    local local_path="$1"
    local remote_url="$2"

    curl -fLo $local_path --create-dirs $remote_url 1>/dev/null 2>&1

    ret="$?"
    success "Download complete"
}

#### main


# vim-monokai
msg "Update 'vim-monokai'"
download_resource "$BASE_PATH/colors/monokai.vim" "https://raw.githubusercontent.com/sickill/vim-monokai/master/colors/monokai.vim"

# vim-plug
msg "Upgrade 'vim-plug'"
vim +PlugUpgrade +qall 1>/dev/null 2>&1

msg "Update Vim plugins"
vim +PlugUpdate +qall 1>/dev/null 2>&1

msg "Rebuild Plugin LeaderF"
cd $BASE_PATH/plugged/LeaderF
./install.sh

msg "Rebuild Plugina YCM "
cd $BASE_PATH/plugged/YouCompleteMe
python3 install.py

ret="$?"
success "Vim configuration updated"
