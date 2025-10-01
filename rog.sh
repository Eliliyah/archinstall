#!/usr/bin/bash

#FUNCTIONS GO HERE

confirm() {         
    while true; do
        read -p "${1}" yn
        case $yn in
            [Yy]* ) $2; break;;
            [Nn]* ) exit;;
            * ) echo "Please answer Y or N.";;
        esac
    done
}
example-function() {
    echo "$2"
}

pacman -Syu

pacman -S asusctl power-profiles-daemon

systemctl enable --now power-profiles-daemon.service

pacman -S supergfxctl switcheroo-control

systemctl enable --now supergfxd
systemctl enable --now switcheroo-control

pacman -S rog-control-center

pacman -Syu



