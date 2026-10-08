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
  ln -sfn "$src" "$dst"
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
    i3-wm \
    i3status \
    picom \
    scrot \
    xclip \
    feh \
    network-manager-applet \
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

setup_bat_theme() {
  if ! command -v bat >/dev/null 2>&1; then
    return
  fi

  local bat_theme_dir
  bat_theme_dir="$(bat --config-dir)/themes"
  mkdir -p "$bat_theme_dir"

  local theme_url="https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme"
  local theme_path="$bat_theme_dir/Catppuccin Mocha.tmTheme"

  if [ ! -f "$theme_path" ]; then
    log "Installing Catppuccin Mocha theme for bat"
    if curl -fsSL "$theme_url" -o "$theme_path"; then
      bat cache --build >/dev/null 2>&1 || true
    else
      log "Failed to download bat theme (Catppuccin Mocha)"
    fi
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

  # Picom
  if [ -f "$SCRIPT_DIR/picom/picom.conf" ]; then
    link "$SCRIPT_DIR/picom/picom.conf" "$HOME/.config/picom/picom.conf"
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
  setup_bat_theme
  setup_default_shell

  log "Done. You may need to restart your shell, tmux, and i3."
}

main "$@"

