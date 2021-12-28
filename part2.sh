echo "ellie ALL=(ALL)ALL">> /etc/sudoers
reflector
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak

pacman -S networkmanager dhclient pacman-contrib curl rsync --needed --noconfirm
pacman -S linux-zen linux-lts --noconfirm
pacman -S git wayland xorg-xwayland gdm wayland-protocols qt5-wayland libva xorg xdg-user-dirs gnome-shell nemo fish opera dhcpcd --noconfirm


systemctl enable NetworkManager
systemctl enable systemd-timesyncd.service
systemctl enable gdm.service
systemctl enable dhcpcd


