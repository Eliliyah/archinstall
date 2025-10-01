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

#Install aur helper
pacman -S aura
confirm "All good?" 

#Install AUR packages
sudo aura -A pamac-all --noconfirm
sudo aura -A stacer-bin chromium-extension-plasma-integration hunspell-en-med-glut-git timeshift timeshift-autosnap --noconfirm
confirm "All good?" 
sudo aura -S pipewire-support --noconfirm
sudo aura -A pipewire-jack-dropin --noconfirm
sudo aura -A debtap masterpdfeditor-free --noconfirm
sudo aura -A appimagelauncher --noconfirm
sudo aura -A hunspell-en-med-glut-git libreoffice-extension-cleandoc libreoffice-extension-languagetool libreoffice-extension-minicorrector ocs-url nerd-fonts-complete onevpl-intel-gpu pacdiff-pacman-hook-git systemd-boot-pacman-hook wd719x-firmware aic94xx-firmware 

sudo aura -A gimp-plugin-gmic gimp-palletes-davidrevoy gimp-plugin-akkana-git gimp-plugin-astronomy gimp-plugin-beautify gimp-plugin-contrastfix gimp-plugin-create-layer-mask-from gimp-plugin-duplicate-to-another-image gimp-plugin-export-layers gimp-plugin-image-reg gimp-plugin-instagram-effects gimp-plugin-layerfx gimp-plugin-layer-via-copy-cut gimp-plugin-pandora gimp-plugin-place-layer-into-selection gimp-plugin-registry gimp-plugin-scale-layer-to-image-size gimp-plugin-toy gimp-plugin-refocus --noconfirm
