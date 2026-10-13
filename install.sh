#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS="$(uname -s)"
LOG_PREFIX="install-arch"

# shellcheck source=scripts/common.sh
source "$SCRIPT_DIR/scripts/common.sh"

ensure_pacman() {
  if ! command -v pacman >/dev/null 2>&1; then
    log "pacman not found – this script is intended for Arch Linux."
    exit 1
  fi
}

install_arch_packages() {
  ensure_pacman

  log "Installing base tools with pacman"
  sudo pacman -Syu --needed --noconfirm \
    base-devel \
    git \
    git-delta \
    curl \
    unzip \
    go \
    nodejs \
    npm \
    tree-sitter-cli \
    zsh \
    neovim \
    tmux \
    fd \
    fzf \
    bat \
    tree \
    lazygit \
    ripgrep \
    alacritty \
    xorg-server \
    xorg-xinit \
    xorg-xrandr \
    lightdm \
    lightdm-gtk-greeter \
    i3-wm \
    i3status \
    i3lock \
    dmenu \
    picom \
    scrot \
    xclip \
    feh \
    brightnessctl \
    pipewire \
    pipewire-pulse \
    wireplumber \
    libpulse \
    networkmanager \
    network-manager-applet \
    noto-fonts \
    noto-fonts-emoji \
    ttf-jetbrains-mono-nerd

  ensure_yay

  log "Installing optional AUR packages with yay"
  yay -S --needed --noconfirm \
    brave-bin \
    telegram-desktop || log "Some AUR packages failed to install"
}

ensure_yay() {
  if command -v yay >/dev/null 2>&1; then
    return
  fi

  log "yay not found – building yay-bin from the AUR"
  local build_dir
  build_dir="$(mktemp -d)"
  git clone https://aur.archlinux.org/yay-bin.git "$build_dir/yay-bin"
  (cd "$build_dir/yay-bin" && makepkg -si --noconfirm)
  rm -rf "$build_dir"
}

setup_default_shell() {
  local zsh_path
  zsh_path="$(command -v zsh)"
  if [ "$(getent passwd "$(id -un)" | cut -d: -f7)" != "$zsh_path" ]; then
    log "Setting default shell to $zsh_path"
    sudo chsh -s "$zsh_path" "$(id -un)"
  fi
}

setup_arch_services() {
  log "Enabling system services"
  sudo systemctl enable NetworkManager.service
  sudo systemctl enable lightdm.service
}

setup_user_dirs() {
  # i3 screenshot bindings write here
  mkdir -p "$HOME/Pictures/Screenshots"
}

setup_arch_symlinks() {
  log "Setting up Arch symlinks"

  link_if_exists "$SCRIPT_DIR/i3/config" "$HOME/.config/i3/config"
  link_if_exists "$SCRIPT_DIR/i3status/config" "$HOME/.config/i3status/config"
  link_if_exists "$SCRIPT_DIR/picom/picom.conf" "$HOME/.config/picom/picom.conf"
  link_if_exists "$SCRIPT_DIR/wallpaper/wallpaper.png" "$HOME/Pictures/wallpaper.png"
}

main() {
  log "Detected OS: $OS"

  if [ "$OS" != "Linux" ]; then
    log "This installer is intended for Arch Linux (Linux). Exiting."
    exit 1
  fi

  install_arch_packages
  setup_common_symlinks
  setup_arch_symlinks
  setup_tmux_plugins
  setup_bat_theme
  setup_default_shell
  setup_arch_services
  setup_user_dirs

  log "Done. Reboot to log in to i3 through LightDM."
}

main "$@"

