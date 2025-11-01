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

#set time
timedatectl set-ntp true
timedatectl set-timezone America/New_York
hwclock --systohc
timedatectl set-ntp true
timedatectl status
locale-gen
confirm "Did the time set correctly?"

#install system services
pacman -S networkmanager sddm lm_sensors acpid power-profiles-daemon bluez bluez-utils pulseaudio-bluetooth blueman preload upower

#Install NVIDIA drivers
sudo pacman -S nvidia-prime nvidia-settings nvidia-utils libva-nvidia-driver linux-firmware-nvidia opencl-nvidia egl-gbm egl-wayland nvidia-lts

#Install asus drivers
pacman -S asusctl rog-control-center asus-fan-control 

#Enable system services
systemctl enable NetworkManager
systemctl enable sddm
systemctl enable lm_sensors
systemctl enable acpid
systemctl enable power-profiles-daemon 
systemctl enable bluetooth
systemctl enable preload
systemctl enable asusd
systemctl enable nvidia-powerd
systemctl enable upower

#install extra packages
pacman -S konsole xterm fish vivaldi iwd plasma plasma-meta discord aura timeshift starship vscodium btop dolphin strawberry libreoffice-fresh ttf-daddytime-mono-nerd kde-style-oxygen-qt6

#Configure journal
echo "Storage=persistent" >> /etc/systemd/journald.conf

#Enable SysRq key
echo "kernel.sysrq = 1" >> /etc/sysctl.d/99-sysctl.conf

#Configure zram
pacman -S zram-generator --noconfirm
cp /archinstall/zram-generator.conf /etc/systemd/zram-generator.conf

configure snapper
cp /archinstall/root /etc/snapper/configs/root

#Configure initramfs for nvidia
sed -i '7,52 s/^/#/' /etc/mkinitcpio.conf
echo "
COMPRESSION="zstd"
MODULES=(crc32c)
BINARIES=()
FILES=()
HOOKS=(base udev autodetect microcode kms modconf block keyboard keymap consolefont filesystems) " >> /etc/mkinitcpio.conf

#Generate the initramfs
mkinitcpio -p linux
mkinitcpio -p linux-zen
mkinitcpio -p linux-lts
