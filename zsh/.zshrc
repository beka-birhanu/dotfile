# Add Homebrew binaries to PATH
export PATH="/opt/homebrew/bin:$PATH"

# ~/.zshrc
export PATH=$PATH:$(go env GOPATH)/bin

for file in ~/dotfile/zsh/configs/*.zsh; do
  [ -r "$file" ] && source "$file"
done

