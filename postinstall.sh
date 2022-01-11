#!/usr/bin/bash

confirm() {         
    while true; do
        read -p "${1}" yn
        case $yn in
            [Yy]* ) $2; break;;
            [Nn]* ) echo "aborted"; exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}
example-function() {
    echo "Excellent. You haven't broken it. Yet."
}

sudo snapper -c root create-config /
sudo snapper create
sudo snapper list
sudo nano /etc/snapper/configs/root
systemctl enable snapper-timeline.timer 
systemctl enable snapper-cleanup.timer
confirm "Are we snapped?"

sudo pacman -Syu --noconfirm

flatpak install flathub mGBA dosbox-staging 

cd /tmp
git clone https://aur.archlinux.org/aura-bin.git
cd aura-bin
makepkg -si
sudo pacman -Syu

sudo aura -S pipewire-support --noconfirm
sudo aura -A pipewire-jack-dropin --noconfirm
sudo aura -A pamac-all --noconfirm
sudo aura -A protonmail-bridge stacer-bin --noconfirm
sudo aura -A debtap masterpdfeditor-free mullvad-vpn virtualbox-ext-oracle --noconfirm
sudo aura -A appimagelauncher --noconfirm
sudo aura -A hunspell-en-med-glut-git intel-cpu-runtime libreoffice-extension-cleandoc libreoffice-extension-languagetool libreoffice-extension-minicorrector ocs-url nerd-fonts-complete onevpl-intel-gpu pacdiff-pacman-hook-git qgnomeplatform systemd-boot-pacman-hook virtualbox-guest-goodies wd719x-firmware aic94xx-firmware 

sudo aura -A gimp-plugin-gmic gimp-palletes-davidrevoy gimp-plugin-akkana-git gimp-plugin-astronomy gimp-plugin-beautify gimp-plugin-contrastfix gimp-plugin-create-layer-mask-from gimp-plugin-duplicate-to-another-image gimp-plugin-export-layers gimp-plugin-image-reg gimp-plugin-instagram-effects gimp-plugin-layerfx gimp-plugin-layer-via-copy-cut gimp-plugin-pandora gimp-plugin-place-layer-into-selection gimp-plugin-registry gimp-plugin-scale-layer-to-image-size gimp-plugin-toy gimp-plugin-refocus --noconfirm
