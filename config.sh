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

#enable late microcode updates
echo 1 > /sys/devices/system/cpu/microcode/reload

#Enable system services
systemctl enable NetworkManager
systemctl enable sddm
systemctl enable lm_sensors
systemctl enable acpid
systemctl enable power-profiles-daemon 
systemctl enable bluetooth
systemctl enable preload

#Configure journal
echo "Storage=persistent" >> /etc/systemd/journald.conf

#Enable SysRq key
echo "kernel.sysrq = 1" >> /etc/sysctl.d/99-sysctl.conf

#Configure zram
pacman -S zram-generator --noconfirm
cp /archinstall/zram-generator.conf /etc/systemd/zram-generator.conf

#Configure initramfs
sed -i '7,52 s/^/#/' /etc/mkinitcpio.conf
echo "
MODULES=(amdgpu radeon)
BINARIES=(btrfs)
FILES=()
HOOKS=(base systemd udev autodetect modconf block keyboard consolefont filesystems resume keymap)" >> /etc/mkinitcpio.conf

#Generate the initramfs
mkinitcpio -p linux
mkinitcpio -p linux-zen
