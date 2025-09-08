# ~/.zshrc
export PATH=$PATH:$(go env GOPATH)/bin

for file in ~/dotfile/zsh/configs/*.zsh; do
  [ -r "$file" ] && source "$file"
done

