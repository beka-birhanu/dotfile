# ~/.zshrc

# Directory of this file, resolved through the ~/.zshrc symlink
ZSH_DOTFILES="${${(%):-%x}:A:h}"

# Add Homebrew binaries to PATH (macOS)
[ -d /opt/homebrew/bin ] && export PATH="/opt/homebrew/bin:$PATH"

command -v go >/dev/null 2>&1 && export PATH="$PATH:$(go env GOPATH)/bin"

for file in "$ZSH_DOTFILES"/configs/*.zsh; do
  [ -r "$file" ] && source "$file"
done

export PATH="$HOME/.local/bin:$PATH"
