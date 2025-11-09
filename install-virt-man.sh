#!/bin/bash

set -e

is_installed() {
  pacman -Qi "$1" &> /dev/null
}
is_group_installed() {
  pacman -Qg "$1" &> /dev/null
}

install_pkgs() {
  local packages=("$@")
  local to_install=()

  echo "Trying to install ${packages[*]}"
  for pkg in "${packages[@]}"; do
    if ! is_installed "$pkg" && ! is_group_installed "$pkg"; then
      to_install+=("$pkg")
    fi
  done

  if [ ${#to_install[@]} -ne 0 ]; then
    echo "Installing ${packages[*]}"
    yay -S --noconfirm "${to_install[@]}"
  fi
}

if ! command -v yay &> /dev/null; then
  echo "Installing yay AUR helper"
  sudo pacman -S --needed base-devel git --noconfirm
  git clone https://aur.archlinux.org/yay.git
  cd yay || exit
  echo "Building yayyyyyyyyy"
  makepkg -si --noconfirm
  cd ..
  rm -rf yay
else
  echo "yay is already installed"
fi

yay -Syu --noconfirm

pkgs=(
  qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat
)
install_pkgs "${pkgs[@]}"

# yay -S --noconfirm ebtables iptables

yay -S --noconfirm 
libguest=(libguestfs dmidecode)
install_pkgs "${libguest[@]}"

echo "Enabling libvirtd service"
sudo systemctl enable libvirtd.service

sudo systemctl start libvirtd.service

# systemctl status libvirtd.service

add_line_if_not_present() {
  line="$1"
  file="$2"
  if ! grep -q "^$line" "$file"; then
    echo "$line" | sudo tee -a "$file" > /dev/null
  else
    echo 'Line already present'
  fi
}

echo "Enabling normal user account to use KVM"
file="/etc/libvirt/libvirtd.conf"

sock_group_line='unix_sock_group = "libvirt"'
sock_rw_perms_line='unix_sock_rw_perms = "0770"'

add_line_if_not_present "$sock_group_line" "$file"
add_line_if_not_present "$sock_rw_perms_line" "$file"

if ! groups | grep -w "$(whoami)";  then
  echo "User not in group"
  sudo usermod -a -G libvirt "$(whoami)"
  newgrp libvirt
  exit
else
  echo "User already in group"
fi

sudo systemctl restart libvirtd.service

echo "Set up network"

target="/etc/libvirt/network.conf"
iptables_line='firewall_backend = "iptables"'

add_line_if_not_present "$iptables_line" "$target"

echo "Network configuration done"
