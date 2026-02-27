#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS="$(uname -s)"

log() {
  printf '[install-arch] %s\n' "$*" >&2
}

backup_if_exists() {
  local target="$1"
  if [ -L "$target" ] && [ ! -e "$target" ]; then
    rm -f "$target"
    return
  fi
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    local backup="${target}.bak.$(date +%s)"
    log "Backing up existing $target -> $backup"
    mv "$target" "$backup"
  fi
}

link() {
  local src="$1"
  local dst="$2"

  mkdir -p "$(dirname "$dst")"
  backup_if_exists "$dst"

  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    log "Symlink already in place: $dst -> $src"
    return
  fi

  log "Linking $dst -> $src"
  ln -s "$src" "$dst"
}

ensure_pacman() {
  if ! command -v pacman >/dev/null 2>&1; then
    log "pacman not found – this script is intended for Arch Linux."
    exit 1
  fi
}

install_arch_packages() {
  ensure_pacman

  log "Installing base tools with pacman"
  sudo pacman -Syu --needed \
    git \
    zsh \
    neovim \
    tmux \
    fd \
    fzf \
    bat \
    tree \
    lazygit \
    ripgrep \
    i3-wm \
    i3status \
    picom \
    scrot \
    xclip \
    feh \
    network-manager-applet \
    ttf-jetbrains-mono-nerd

  if command -v yay >/dev/null 2>&1; then
    log "Installing optional AUR packages with yay"
    yay -S --needed \
      brave-bin \
      telegram-desktop || true
  fi
}

setup_tmux_plugins() {
  local tpm_dir="$HOME/.config/tmux/plugins/tpm"
  if [ ! -d "$tpm_dir" ]; then
    log "Installing tmux plugin manager (tpm)"
    git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
  fi
}

setup_symlinks() {
  log "Setting up symlinks"

  # Zsh
  link "$SCRIPT_DIR/zsh/.zshrc" "$HOME/.zshrc"

  # Git
  if [ -f "$SCRIPT_DIR/git/.gitconfig" ]; then
    link "$SCRIPT_DIR/git/.gitconfig" "$HOME/.gitconfig"
  fi

  # Lazygit
  if [ -f "$SCRIPT_DIR/lazygit/config.yml" ]; then
    link "$SCRIPT_DIR/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"
  fi

  # Neovim
  if [ -d "$SCRIPT_DIR/nvim" ]; then
    link "$SCRIPT_DIR/nvim" "$HOME/.config/nvim"
  fi

  # Tmux
  if [ -f "$SCRIPT_DIR/tmux/tmux.conf" ]; then
    link "$SCRIPT_DIR/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
  fi

  # Alacritty
  if [ -f "$SCRIPT_DIR/alacritty/alacritty.toml" ]; then
    link "$SCRIPT_DIR/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
  fi

  # i3 / i3status
  if [ -f "$SCRIPT_DIR/i3/config" ]; then
    link "$SCRIPT_DIR/i3/config" "$HOME/.config/i3/config"
  fi
  if [ -f "$SCRIPT_DIR/i3status/config" ]; then
    link "$SCRIPT_DIR/i3status/config" "$HOME/.config/i3status/config"
  fi

  # LS_COLORS (Catppuccin-converted)
  if [ -f "$SCRIPT_DIR/zsh/LS_COLORS" ]; then
    link "$SCRIPT_DIR/zsh/LS_COLORS" "$HOME/.config/LS_COLORS"
  fi
}

main() {
  log "Detected OS: $OS"

  if [ "$OS" != "Linux" ]; then
    log "This installer is intended for Arch Linux (Linux). Exiting."
    exit 1
  fi

  install_arch_packages
  setup_symlinks
  setup_tmux_plugins

  log "Done. You may need to restart your shell, tmux, and i3."
}

main "$@"

