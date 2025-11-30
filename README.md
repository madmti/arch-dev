
# My Arch respin

> Reproducible, lightweight and modular Arch Linux config based on Hyprland.
> Managed via **GNU Stow** and automated with **Make**.

## Quick Start

Start with a fresh minimal installation of Arch Linux with No Desktop. Then clone this repo and install via **Make**:
```bash
# Clone repo
git clone https://github.com/madmti/arch-dev.git ~/dotfiles

# Run Installer
cd ~/dotfiles
make
```

> Important!: The installer overwrites .bash_profile and .bashrc so your bash config will be overwritten

## Keybinding

| key | Action |
| :--- | :--- |
| `Alt + T` | Terminal (Kitty) |
| `Alt + E` | File Manager (Thunar) |
| `Alt + Space` | App Launcher |
| `Alt + M` | Exit Hyprland |
| `Alt + C` | Close Window |

## Structure

- `hypr/` - Hyprland configs.
- `shell/` - Bash aliases and environment variables
- `tools/` - Custom source code (Go) for system tools
- `pkglist.txt` - Immutable list of base system pacakges

