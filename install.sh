#!/usr/bin/env bash

echo "Updating system"
sudo pacman -Syu --noconfirm

echo "Installing packages"
sudo pacman -S --needed - < pkglist.txt

echo "Base instalation complete"

