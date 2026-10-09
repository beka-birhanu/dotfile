#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS="$(uname -s)"
LOG_PREFIX="install-macos"

# shellcheck source=scripts/common.sh
source "$SCRIPT_DIR/scripts/common.sh"

ensure_brew() {
  if command -v brew >/dev/null 2>&1; then
    return
  fi

  log "Homebrew not found – installing"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

install_macos_packages() {
  ensure_brew

  log "Installing tools with Homebrew"
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
    git-delta \
    oath-toolkit \
    ripgrep \
    brave-browser

  brew install --cask alacritty || true
  brew tap nikitabobko/tap || true
  brew install --cask aerospace || true
  brew install --cask karabiner-elements || true
  brew install --cask font-jetbrains-mono-nerd-font || true
}

setup_macos_symlinks() {
  log "Setting up macOS symlinks"

  link_if_exists "$SCRIPT_DIR/aerospace/aerospace.toml" "$HOME/.aerospace.toml"
  link_if_exists "$SCRIPT_DIR/karabiner/karabiner.json" "$HOME/.config/karabiner/karabiner.json"
  link_if_exists "$SCRIPT_DIR/karabiner/assets/complex_modifications" "$HOME/.config/karabiner/assets/complex_modifications"
}

main() {
  log "Detected OS: $OS"

  if [ "$OS" != "Darwin" ]; then
    log "This installer is intended for macOS only. Exiting."
    exit 0
  fi

  install_macos_packages
  setup_common_symlinks
  setup_macos_symlinks
  setup_tmux_plugins
  setup_bat_theme

  log "Done. You may need to restart your shell and tmux."
  log "If you face issues with tree-sittter specially \"no such file or directory (cmd):'tree-sitter'\" run brew install tree-sitter-cli"
  log "If not it looks like they have fixed the issue and started distrubuting the pre-built binaries"
}

main "$@"
