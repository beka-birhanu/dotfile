#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS="$(uname -s)"

log() {
  printf '[install] %s\n' "$*" >&2
}

backup_if_exists() {
  local target="$1"
  if [ -L "$target" ] && [ ! -e "$target" ]; then
    # broken symlink – just remove
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

ensure_brew() {
  if command -v brew >/dev/null 2>&1; then
    return
  fi

  log "Homebrew not found – installing"
  if [ "$OS" = "Darwin" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    log "Non-macOS OS detected; not installing Homebrew automatically."
  fi
}

install_common_packages() {
  ensure_brew

  if command -v brew >/dev/null 2>&1; then
    log "Installing common tools with Homebrew"
    brew update
    brew install \
      git \
      neovim \
      tmux \
      zsh \
      fd \
      fzf \
      bat \
      tree \
      lazygit \
      delta \
      oath-toolkit \
      ripgrep
  fi
}

install_macos_packages() {
  [ "$OS" = "Darwin" ] || return
  ensure_brew

  log "Installing macOS-specific tools with Homebrew"
  brew install --cask alacritty || true
  brew tap nikitabobko/tap || true
  brew install --cask aerospace || true
  brew install --cask karabiner-elements || true
  brew tap homebrew/cask-fonts || true
  brew install --cask font-jetbrains-mono-nerd-font || true
}

setup_tmux_plugins() {
  local tpm_dir="$HOME/.config/tmux/plugins/tpm"
  if [ ! -d "$tpm_dir" ]; then
    log "Installing tmux plugin manager (tpm)"
    git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
  fi
}

setup_karabiner() {
  # Main karabiner.json
  if [ -f "$SCRIPT_DIR/karabiner/karabiner.json" ]; then
    link "$SCRIPT_DIR/karabiner/karabiner.json" "$HOME/.config/karabiner/karabiner.json"
  fi

  # Complex modifications directory (optional)
  if [ -d "$SCRIPT_DIR/karabiner/assets/complex_modifications" ]; then
    link "$SCRIPT_DIR/karabiner/assets/complex_modifications" "$HOME/.config/karabiner/assets/complex_modifications"
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

  # AeroSpace
  if [ -f "$SCRIPT_DIR/aerospace/aerospace.toml" ]; then
    link "$SCRIPT_DIR/aerospace/aerospace.toml" "$HOME/.aerospace.toml"
  fi
}

main() {
  log "Detected OS: $OS"

  if [ "$OS" != "Darwin" ]; then
    log "This installer is intended for macOS only. Exiting."
    exit 0
  fi

  install_common_packages

  install_macos_packages

  setup_symlinks
  setup_tmux_plugins
  setup_karabiner

  log "Done. You may need to restart your shell and tmux."
}

main "$@"

