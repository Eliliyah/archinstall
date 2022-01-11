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
confirm "Are you ready to keep going?" 

#Generate locales
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8">> /etc/locale.gen
locale-gen 
confirm "Did locales generate?"
echo "LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8
LC_ADDRESS=en_US.UTF-8
LC_NAME=en_US.UTF-8
LC_MONETARY=en_US.UTF-8
LC_PAPER=en_US.UTF-8
LC_IDENTIFICATION=en_US.UTF-8
LC_TELEPHONE=en_US.UTF-8
LC_MEASUREMENT=en_US.UTF-8
LC_TIME=en_US.UTF-8
LC_NUMERIC=en_US.UTF-8
LANGUAGE=en_US.UTF-8">> /etc/locale.conf
echo "KEYMAP=us
FONT=Lat2-Terminus16">> /etc/vconsole.conf
echo "ellie">> /etc/hostname
nano /etc/locale.gen
confirm "Did the time set correctly?" 

#Set the root password
passwd

#add yourself as a user
useradd -m -G wheel -s /bin/bash ellie
passwd ellie
echo "ellie ALL=(ALL)ALL">> /etc/sudoers

confirm "Do you exist now?" 

#Install LTS kernel
pacman -S linux-lts --noconfirm

#Install important packages
pacman -Syu --noconfirm
pacman -S networkmanager dhclient pacman-contrib dhcpcd rsync opera --noconfirm

#Install build tools
pacman -S go meson cmake extra-cmake-modules rust flatpak snapd yajl wget curl --noconfirm
confirm "Did everything install?" 

#Move and copy files
mkdir /etc/backupfolder
#mv /etc/pacman.d/mirrorlist /etc/backupfolder
#mv /etc/pacman.conf /etc/backupfolder
mv /etc/mkinitcpio.conf /etc/backupfolder
#cp /archinstall/mirrorlist /etc/pacman.d/mirrorlist
#cp /archinstall/pacman.conf /etc/pacman.conf
#cp /archinstall/endeavouros-mirrorlist /etc/pacman.d/endeavouros-mirrorlist
cp /archinstall/mkinitcpio.conf /etc/mkinitcpio.conf
ls /etc/backupfolder
confirm "Did all the files copy successfully?" 

#Install plasma 
pacman -Syu --noconfirm
pacman -S plasma sddm --noconfirm
pacman -S konsole ark dolphin dolphin-plugins ffmpegthumbs gwenview kalarm kamoso kcalc kdegraphics-thumbnailers kdesdk-thumbnailers kfind kmix ksystemlog ktorrent okular spectacle sweeper systemd-ui aspell-en libappimage os-prober blueberry --noconfirm

pacman -S fish gimp libreoffice-fresh discord meld file-roller opera-ffmpeg-codecs bitwarden code inkscape strawberry thunderbird bpytop firefox pam-u2f rclone gparted --noconfirm

#Install virtualbox
pacman -S virtualbox-ext-vnc virtualbox-guest-iso virtualbox-guest-utils virtualbox-host-dkms virtualbox-sdk --noconfirm

pacman -S pipewire sof-firmware

pacman -S pipewire-alsa pipewire-jack pipewire-media-session pipewire-pulse pipewire-v4l2 pipewire-zeroconf gst-plugin-pipewire pulseaudio-qt alsa-card-profiles jack2 lv2 openal opus --noconfirm

chmod +x postinstall.sh
confirm "Are we gooeyed?" 

#Install thermald
pacman -S thermald --noconfirm
systemctl enable thermald.service

#Enable system services
systemctl enable NetworkManager
systemctl enable dhcpcd
systemctl enable sddm.service
systemctl enable power-profiles-daemon 
systemctl --user enable pipewire.service pipewire-pulse.service
systemctl enable bluetooth.service
confirm "Did system services enable?" 

#Run mkinitcpio 
mkinitcpio -p linux
mkinitcpio -p linux-zen
mkinitcpio -p linux-lts
confirm "Did it work?" 

#Install grub
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
mv /archinstall/EllieOS /usr/share/grub/themes
echo "GRUB_THEME="/usr/share/grub/themes/EllieOS/theme.txt"">> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
confirm "All good?" 
