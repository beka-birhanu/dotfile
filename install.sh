#!/bin/bash

# Function to ask for confirmation
ask_confirmation() {
  echo "$1 [y/n]"
  read response
  if [ "$response" != "y" ]; then
    echo "You chose wisely, my friend. Exiting."
    exit 1
  fi
}

# Function to check and install a package
install_package() {
  if ! command -v "$1" &> /dev/null; then
    echo "$1 is missing. Installing $1..."
    sudo pacman -S --needed "$1" || { echo "Failed to install $1. Exiting."; exit 1; }
    echo "$1 installed successfully."
  else
    echo "$1 is already installed. Skipping."
  fi
}

# Function to copy configuration files
copy_config() {
  local source_path="$1"
  local dest_path="$HOME/.config/$(basename "$source_path")"
  if [ -d "$source_path" ]; then
    echo "Copying configuration from $source_path to $dest_path"
    cp -r "$source_path" "$dest_path" || { echo "Failed to copy $source_path configuration. Exiting."; exit 1; }
    echo "$source_path configuration copied successfully."
  elif [ -f "$source_path" ]; then
    echo "Copying configuration file $source_path to $dest_path"
    cp "$source_path" "$dest_path" || { echo "Failed to copy $source_path configuration file. Exiting."; exit 1; }
    echo "$source_path configuration file copied successfully."
  else
    echo "$source_path configuration does not exist. Skipping."
  fi
}

# Function to install NVM and Node.js
install_nvm_node() {
  if ! command -v nvm &> /dev/null; then
    if ! command -v curl &> /dev/null; then
      echo "curl is required to install nvm. Installing curl..."
      sudo pacman -S --needed curl || { echo "Failed to install curl. Exiting."; exit 1; }
    fi
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash || { echo "Failed to install NVM. Exiting."; exit 1; }
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
    echo "Installing the latest Node.js version using NVM..."
    nvm install node || { echo "Failed to install Node.js. Exiting."; exit 1; }
    echo "Node.js installed successfully."
  else
    echo "NVM is already installed. Skipping."
  fi
}

# Install Tmux Plugin Manager (TPM)
install_tpm() {
  if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing Tmux Plugin Manager (TPM)..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm" || { echo "Failed to install TPM. Exiting."; exit 1; }
    echo "TPM installed successfully."
  else
    echo "TPM is already installed. Skipping."
  fi
}

# Main setup function
setup_environment() {
  # Welcome message
  echo "Welcome, Archer! Ready to set up your development environment?"
  ask_confirmation "Are you using Arch Linux and ready to proceed?"

  # Dependencies and their configs
  declare -A packages_and_configs=(
    [git]="./git/.gitconfig"
    [neovim]="./nvim"
    [python]=""
    [ripgrep]=""
    [lazygit]=""
    [npm]=""
    [zsh]="./zsh"
    [alacritty]="./alacritty"
    [tmux]="./tmux"
  )

  # Install packages and copy configs
  for package in "${!packages_and_configs[@]}"; do
    install_package "$package"
    if [ -n "${packages_and_configs[$package]}" ]; then
      copy_config "${packages_and_configs[$package]}"
    fi
  done

  # Install NVM and Node.js
  install_nvm_node

  # Install Tmux Plugin Manager
  install_tpm

  # Final message
  echo "Your development environment is ready! Neovim, zsh, alacritty, tmux, TPM, and other dependencies are set up. Go forth and code!"
}

# Execute the main setup
setup_environment

