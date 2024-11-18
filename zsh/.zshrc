# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Zinit Configuration
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Powerlevel10k
zinit ice depth=1
zinit light romkatv/powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Completion System
autoload -Uz compinit && compinit

# History Configuration
HISTSIZE=1000
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history
setopt append_history share_history hist_ignore_space hist_ignore_dups

# Aliases
alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias nv='nvim'
alias fnv='nvim $(fzf --preview "cat {}")'
alias src='source ~/.zshrc'
alias go-m='cd ~/Desktop/mereb/'
alias go-mc-nv='go-m && cd mereb-ats-client && nv'
alias go-ma-nv='go-m && cd mereb-ats-api && nv'
alias go-cd='cd ~/Desktop/class_2024/dist/'
alias go-cd-nv='go-cd && nv'


# Environment Variables
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # Load NVM
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # Load NVM completion

# Go Environment
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin
function go_version {
    if [ -f "go.mod" ]; then
        v=$(grep -E '^go \d.+$' ./go.mod | grep -oE '\d.+$')
        if [[ ! $(go version | grep "go$v") ]]; then
          echo ""
          echo "About to switch go version to: $v"
          if ! command -v "$HOME/go/bin/go$v" &> /dev/null; then
            echo "run: go install golang.org/dl/go$v@latest && go$v download && sudo cp \$(which go$v) \$(which go)"
            return
          fi
          sudo cp $(which go$v) $(which go)
        fi
    fi
}

# Syntax Highlighting, Autosuggestions, and Completions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

# Keybindings
bindkey '^j' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[[1;5C' forward-word      # Ctrl + Right Arrow
bindkey '^[[1;5D' backward-word     # Ctrl + Left Arrow

# Custom Kill Program
alias kp="ps aux | fzf | awk '{print \$2}' | xargs kill -9"

# Custom Colors for Completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Open images with image previewr
function io {
    if [[ "$1" =~ \.(jpg|jpeg|png|gif|bmp|tiff)$ ]]; then
        xdg-open "$1"
    else
        echo "File type not supported for auto-opening."
    fi
}

# OTP for github
function ghotp {
  oathtool --totp -b "$1"
}

