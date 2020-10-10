#!/bin/bash

PACKAGES_LIST="vim \
    tmux \
    rxvt-unicode \
    bash-completion \
    cscope \
    universal-ctags"

install_packages() {
    sudo pacman -S ${PACKAGES_LIST}
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
