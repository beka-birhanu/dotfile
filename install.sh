#!/bin/bash

# Function to ask for confirmation
ask_confirmation() {
  echo -e "$1 [y/n]"
  read -r response
  if [[ "$response" != "y" ]]; then
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

# Function to create symbolic links
sm_link_config() {
    local source_path="$1"
    local symlink_dir="$2"

    # Ensure the parent directory of the symlink exists
    mkdir -p "$(dirname "$symlink_dir")"

    # Create the symbolic link without force (-f)
    ln -s "$source_path" "$symlink_dir"

    # Check if ln was successful
    if [[ $? -eq 0 ]]; then
        echo "Symlink created: $source_path -> $symlink_dir"
    else
        echo "Error: Failed to create symlink for '$source_path'!" >&2
    fi
}

# Install Tmux Plugin Manager (TPM)
install_tpm() {
  if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    echo "Installing Tmux Plugin Manager (TPM)..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm" || { echo "Failed to install TPM. Exiting."; exit 1; }
    echo "TPM installed successfully."
  else
    echo "TPM is already installed. Skipping."
  fi
}

# Main setup function
setup_environment() {
  echo "Welcome, a soy dev who couldn't install things themselves."
  ask_confirmation "Do you have pacman, or are you still using apt? 😹"

  # Declare an associative array mapping package names to config paths
  declare -A packages_and_configs=(
      [git]="./git/.gitconfig ~/.gitconfig"
      [neovim]="./nvim ~/.config/nvim" 
      [zsh]="./zsh ~/.zshrc"
      [alacritty]="./alacritty ~/.config/alacritty"
      [tmux]="./tmux ~/.config/tmux"
  )

  declare -a packages=(
      ripgrep
      lazygit
      lazydocker
      git
      neovim
      zsh
      alacritty
      tmux
  ) 

  # Install packages and link configs
  for package in "${packages[@]}"; do
      install_package "$package"

      # Check if the package has a corresponding config in the associative array
      if [[ -n "${packages_and_configs[$package]}" ]]; then
          sm_link_config "${packages_and_configs[$package]}"
      fi
  done

  # Install Tmux Plugin Manager
  install_tpm

  # Final message
  echo "Your dev environment is ready! Neovim, Zsh, Alacritty, Tmux, and TPM are installed."
  echo "Now, the only issue left is your skill. 👀 👃 👀"
}

# Execute the main setup
setup_environment

