#!/usr/bin/env bash

############################  SETUP PARAMETERS
ROOT_PATH=$(dirname "${BASH_SOURCE[0]}")

############################  BASIC SETUP TOOLS
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

program_exists() {
    local ret='0'
    command -v $1 >/dev/null 2>&1 || { local ret='1';  }

    # fail on non-zero return value
    if [ "$ret" -ne 0  ]; then
        return 1
    fi

    return 0
}

program_must_exist() {
    program_exists $1

    # throw error on non-zero return value
    if [ "$?" -ne 0  ]; then
        error "You must have '$1' installed to continue."
    fi
}

argument_set() {
    if [ -z "$1" ]; then
        error "You must have your arguments set before continue."
    fi
}

############################ SETUP FUNCTIONS
download_resource() {
    argument_set "$1"
    argument_set "$2"
    argument_set "$3"

    local resource_id="$1"
    local local_path="$2"
    local remote_url="$3"

    curl -fLo $ROOT_PATH/$local_path --create-dirs $remote_url \
        1>/dev/null 2>&1

    ret="$?"
    success "Plugin $resource_id downloaded."
}

update_plugin() {
    local plugins_table=( \
        "vim-plug, autoload/plug.vim, https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" \
        "vim-monokai, colors/monokai.vim, https://raw.githubusercontent.com/sickill/vim-monokai/master/colors/monokai.vim")


    for i in "${!plugins_table[@]}"; do
        IFS=', ' read -r -a entry <<< "${plugins_table[i]}"
        download_resource "${entry[0]}" \
                          "${entry[1]}" \
                          "${entry[2]}"
    done

    ret="$?"
    success "Successfully update plugins."
}

############################ MAIN()
program_must_exist "curl"

update_plugin

msg "Done!"
