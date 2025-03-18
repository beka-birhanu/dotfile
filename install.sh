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
  if ! pacman -Qi "$1" &> /dev/null; then
    echo "$1 is missing. Installing $1..."
    
    if sudo pacman -S --needed "$1"; then
      echo "$1 installed successfully using pacman."
      return 0
    fi
    
    echo "Pacman failed to install $1. Trying yay..."
    
    if command -v yay &> /dev/null && yay -S --needed "$1"; then
      echo "$1 installed successfully using yay."
      return 0
    fi
    
    echo "Neither pacman nor yay could install $1. Sorry, looks like you are going to have to build it yourself."
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
  if [[ ! -d "$HOME/.config/tmux/plugins/tpm" ]]; then
    echo "Installing Tmux Plugin Manager (TPM)..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm" || { echo "Failed to install TPM. Exiting."; exit 1; }
    echo "TPM installed successfully."
  else
    echo "TPM is already installed. Skipping."
  fi
}

# Main setup function
setup_environment() {
  echo "Welcome, dady."
  ask_confirmation "You are using pacman, not apt, Right? 😹"

  # Declare an associative array mapping package names to config paths
  declare -A packages_and_configs=(
      [alacritty]="./alacritty $HOME/.config/alacritty"
      [git]="./git/.gitconfig $HOME/.gitconfig"
      [i3]="./i3 $HOME/.config/i3"
      [i3status]="./i3status $HOME/.config/i3status"
      [neovim]="./nvim $HOME/.config/nvim" 
      [picom]="./picom $HOME/.config/picom" 
      [tmux]="./tmux $HOME/.config/tmux"
      [zsh]="./zsh $HOME/.zshrc"
  )

  declare -a packages=(
      alacritty
      git
      i3
      i3status
      i3lock
      i3bar
      lazydocker
      lazygit
      neovim
      ripgrep
      tmux
      zsh 
  ) 

  # Did even bother to find a better way to handle yay
  sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd ..

  # Install packages and link configs
  for package in "${packages[@]}"; do
      install_package "$package"

      # Check if the package has a corresponding config in the associative array
      if [[ -n "${packages_and_configs[$package]}" ]]; then
        read -r source_path symlink_dir <<< "${packages_and_configs[$package]}"
        sm_link_config "$source_path" "$symlink_dir"
      fi
  done

  # Install Tmux Plugin Manager
  install_tpm
  
  chsh -s $(which zsh) # make zsh defalut shell 

  # Final message
  echo "Your dev environment is ready! Neovim, Zsh, Alacritty, Tmux, and TPM are installed."
  echo "Now, the only issue left is your skill. 👀 👃 👀"
}

# Execute the main setup
setup_environment
