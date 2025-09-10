# -------------------------
# Aliases
# -------------------------
alias cat='bat --style=plain --pager=never --theme="Catppuccin Mocha"'
alias ls='ls --color=auto'
alias sysup='sudo pacman -Syu --noconfirm && yay -Syu --noconfirm'

# -------------------------
# Functions
# -------------------------
# Safe fzf wrappers (cancel = no action)
fcd() { # cd to directory after selecting from fd with fzf
  local dir=$(fd --type d | fzf --preview "tree -C {} | head -50") || return
  [[ -n "$dir" ]] && cd "$dir"
}
fnv() { # open file with nvim after selecting from fd with fzf
  local file=$(fzf --preview "bat --style=plain --color=always {}") || return
  [[ -n "$file" ]] && nvim "$file"
}
fdnv() { # cd to directory and open nvim after selecting from fd with fzf
  local dir=$(fd --type d | fzf --preview "tree -C {} | head -50") || return
  [[ -n "$dir" ]] && cd "$dir" && nvim
}
kp() { # kill process with fzf
  local pid=$(ps aux | fzf | awk '{print $2}') || return
  [[ -n "$pid" ]] && kill -9 "$pid"
}
ta() { # attach to tmux session with fzf
  local session=$(tmux list-sessions | awk -F':' '{print $1}' | fzf) || return
  [[ -n "$session" ]] && tmux attach -t "$session"
}

# Image preview
image() {
    [[ "$1" =~ \.(jpg|jpeg|png|gif|bmp|tiff)$ ]] && xdg-open "$1" || echo "Unsupported file"
}

# GitHub OTP
ghotp() {
  [[ -z "$1" ]] && { echo "Usage: ghotp <secret>"; return 1; }
  oathtool --totp -b "$1"
}
