#!/usr/bin/env bash

echo "Updating system"
sudo pacman -Syu --noconfirm

echo "Installing packages"
sudo pacman -S --needed - < pkglist.txt

echo "Base instalation complete"


echo "Configuring display manager (Ly)"
sudo cp ~/dotfiles/etc/ly/config.ini /etc/ly/config.ini
sudo systemctl enable ly


