#!/usr/bin/env bash
# Shared helpers for the per-platform install.sh scripts.
# The caller must set SCRIPT_DIR (repo root) before sourcing this file,
# and may set LOG_PREFIX.

log() {
  printf '[%s] %s\n' "${LOG_PREFIX:-install}" "$*" >&2
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
  ln -sfn "$src" "$dst"
}

link_if_exists() {
  local src="$1"
  local dst="$2"
  if [ -e "$src" ]; then
    link "$src" "$dst"
  fi
}

setup_common_symlinks() {
  log "Setting up common symlinks"

  link "$SCRIPT_DIR/zsh/.zshrc" "$HOME/.zshrc"
  link_if_exists "$SCRIPT_DIR/zsh/LS_COLORS" "$HOME/.config/LS_COLORS"
  link_if_exists "$SCRIPT_DIR/git/.gitconfig" "$HOME/.gitconfig"
  link_if_exists "$SCRIPT_DIR/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"
  link_if_exists "$SCRIPT_DIR/nvim" "$HOME/.config/nvim"
  link_if_exists "$SCRIPT_DIR/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
  link_if_exists "$SCRIPT_DIR/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
}

setup_tmux_plugins() {
  local tpm_dir="$HOME/.config/tmux/plugins/tpm"
  if [ ! -d "$tpm_dir" ]; then
    log "Installing tmux plugin manager (tpm)"
    git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
  fi
}

setup_bat_theme() {
  if ! command -v bat >/dev/null 2>&1; then
    return
  fi

  local bat_theme_dir
  bat_theme_dir="$(bat --config-dir)/themes"
  mkdir -p "$bat_theme_dir"

  # The file name is the theme name used by the `cat` alias and delta
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
