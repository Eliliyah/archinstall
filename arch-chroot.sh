arch-chroot /mnt

pacman -S networkmanager dhclient pacman-contrib curl reflector rsync --noconfirm
systemctl enable --now NetworkManager
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
timedatectl --no-ask-password set-timezone America/New_York
timedatectl --no-ask-password set-ntp 1
localectl --no-ask-password set-locale LANG="en_US.UTF-8" LC_TIME="en_US.UTF-8"
localectl --no-ask-password set-keymap us
sed -i 's/^#Para/Para/' /etc/pacman.conf
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
pacman -S git base-devel wayland xorg-xwayland gdm wayland-protocols qt5-wayland libva xorg xdg-user-dirs gnome gnome-shell gnome-tweaks gnome-shell-extensions gnome-power-manager gnome-color-manager gnome-calculator gnome-disk-utility gnome-control-center gnome-system-monitor gnome-screenshot gnome-autoar gnome-bluetooth gnome-common gnome-desktop gnome-keyring gnome-nettool gnome-online-accounts gnome-session gnome-settings-daemon eog nemo fish opera 