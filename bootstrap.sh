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

# .vimrc
if [ ! -e $HOME/.vimrc ]; then
    msg "Create symbolic link \"$HOME/.vimrc\" -> \"$BASE_PATH/vimrc\""
    echo ln -s $BASE_PATH/vimrc $HOME/.vimrc
fi

# .vim
if [ ! -e $HOME/.vim ]; then
    msg "Create symbolic link \"$HOME/.vim\" -> \"$BASE_PATH\""
    echo ln -s $BASE_PATH $HOME/.vim
fi

# vim-plug
if [ ! -e "$BASE_PATH/autoload/plug.vim" ]; then
    msg "Install 'vim-plug' from Internet"
    download_resource "$BASE_PATH/autoload/plug.vim" "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
fi

# vim-monokai
if [ ! -e "$BASE_PATH/colors/monokai.vim" ]; then
    msg "Install 'vim-monokai' from Internet"
    download_resource "$BASE_PATH/colors/monokai.vim" "https://raw.githubusercontent.com/sickill/vim-monokai/master/colors/monokai.vim"
fi
