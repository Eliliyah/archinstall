#!/usr/bin/bash

#FUNCTIONS GO HERE

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

#sync home files
pacman -S --needed rsync starship fish --noconfirm
rsync -av /archinstall/files/.bash_aliases /home/ellie/
rsync -av /archinstall/files/bash_aliases /home/ellie/
rsync -av /archinstall/files/bashrc /home/ellie/
rsync -av /archinstall/files/fish_aliases /home/ellie
rsync -av /archinstall/files/update.sh /home/ellie
rsync -av /archinstall/files/starship.toml /home/ellie/.config/
mkdir /home/ellie/.config/fish/
rsync -av /archinstall/files/config.fish /home/ellie/.config/fish/
rsync -av /archinstall/files/fish_variables /home/ellie/.config/fish/
mkdir /home/ellie/.config/fish/conf.d/
rsync -av /archinstall/files/uv.env.fish /home/ellie/.config/fish/conf.d/uv.env.fish
mkdir /home/ellie/.local/bin/
rsync -av /archinstall/files/env.fish /home/ellie/.local/bin/env.fish
mkdir /home/ellie/Pictures/
rsync -av /archinstall/files/arch_pink_background.png /home/ellie/Pictures
rsync -av /archinstall/files/ellieossticker_small.png /home/ellie/Pictures
rsync -av /archinstall/files/home_files.zip/ /home/ellie/Downloads
mkdir /home/ellie/archinstall/
rsync -av /archinstall/ /home/ellie/archinstall/