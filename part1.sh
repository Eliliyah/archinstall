
#!/usr/bin/bash
timedatectl set-ntp true

fdisk -l
fdisk /dev/nvme0n1
mkfs.fat -F 32 /dev/nvme0n01
mkswap /dev/nvme0n02
mkfs.btrfs /dev/nvme0n03

mount /dev/nvme0n03 /mnt
mkdir /mnt/boot
mount /dev/nvme0n01 /mnt/boot
swapon /dev/nvme0n02

pacstrap /mnt base linux linux-firmware
pacstrap /mnt dhcpcd linux-zen base-devel btrfs-progs iw gptfdisk zsh terminus-font intel-ucode snapper grub dosfstools man-db man-pages nano usbutils which neofetch iwctl fish efibootmgr efivars reflector reflector-simple systemd perl perl-timedate zstd 

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt

pacman -S networkmanager dhclient --noconfirm --needed
systemctl enable --now NetworkManager
pacman -S --noconfirm pacman-contrib curl
pacman -S --noconfirm reflector rsync
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
timedatectl --no-ask-password set-timezone America/New_York
timedatectl --no-ask-password set-ntp 1
localectl --no-ask-password set-locale LANG="en_US.UTF-8" LC_TIME="en_US.UTF-8"
localectl --no-ask-password set-keymap us
sed -i 's/^# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
sed -i 's/^#Para/Para/' /etc/pacman.conf
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
pacman -Sy --noconfirm

pacman -S git base-devel wayland xorg-xwayland gdm wayland-protocols qt5-wayland libva xorg xdg-user-dirs gnome gnome-shell gnome-tweaks gnome-shell-extensions gnome-power-manager gnome-color-manager gnome-calculator gnome-disk-utility gnome-control-center gnome-system-monitor gnome-screenshot gnome-autoar gnome-bluetooth gnome-common gnome-desktop gnome-keyring gnome-nettool gnome-online-accounts gnome-session gnome-settings-daemon eog nemo fish opera --noconfirm
