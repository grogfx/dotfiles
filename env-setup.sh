#!/bin/bash

PACKAGES_LIST="i3 \
    vim \
    tmux \
    rxvt-unicode \
    feh \
    xautolock \
    bash-completion \
    fonts-croscore"

install_packages() {
    sudo apt install ${PACKAGES_LIST}
}

USER_HOME=${USER_HOME:-/home/${USER}}
update_xresources() {
    xrdb -merge ${USER_HOME}/.Xresources
    xrdb -load ${USER_HOME}/.Xresources
    fc-cache
}

main() {
    install_packages
    update_xresources
}

main "$@"
