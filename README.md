## Dotfiles Overview

This repository contains my dotfiles for shell, Neovim, tmux, terminal, and window-manager setups. It is organized around a **shared base** (`master`) and **OS-specific branches** (`macOS` and `arch`).

### Branches and Roles

- **master**
  - Shared, OS-agnostic configuration only.
  - **Rule**: All cross-OS edits start here. Then they are merged/rebased into the OS branches.

- **macOS**
  - Based on `master`, plus **macOS-only** configuration.
  - Examples:
    - `aerospace/aerospace.toml` – AeroSpace tiling WM config.
    - Zsh aliases that use `brew` (e.g. `sysup` runs `brew update && brew upgrade && brew cleanup`).
    - macOS-oriented tmux plugins (e.g. `tmux-battery-osx`) and any future Mac-specific tweaks.
  - Use this branch on macOS machines and for changing macOS-specific behavior.

- **arch**
  - Based on `macOS`’s feature set but with **Arch/i3-specific** configuration and no macOS-only tools.
  - Examples:
    - `i3/config` – i3 window manager config.
    - `i3status/config` – i3status bar configuration.
    - Zsh `sysup` alias using `pacman`/`yay` for system updates.
  - Use this branch on Arch/i3 machines and for changing Arch-specific behavior.

his model keeps `master` clean and portable, while `macOS` and `arch` carry only the extra config needed for each platform.
