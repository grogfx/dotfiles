#!/bin/bash

PACKAGES_LIST="i3 \
    vim \
    tmux \
    rxvt-unicode \
    feh \
    xautolock"

install_packages() {
    sudo apt install ${PACKAGES_LIST}
}

update_xresources() {
    xrdb -merge ${USER_HOME}/.Xresources
    xrdb -load ${USER_HOME}/.Xresources
}

main() {
    install_packages
    update_xresources
}

main "$@"
