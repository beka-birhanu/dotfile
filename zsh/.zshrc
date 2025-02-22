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
function zshaddhistory() {
    emulate -L zsh
    if [[ $1 = *"ghotp"* ]] ; then
        return 1
    fi
}

# Aliases
alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias nv='nvim'
alias fnv='nvim $(fzf --preview "cat {}")'
alias src='source ~/.zshrc'
alias go-m='cd ~/Documents/mereb/'
alias go-mc-nv='go-m && cd mereb-ats-client && nv'
alias go-ma-nv='go-m && cd mereb-ats-api && nv'
alias go-cd='cd ~/Documents/class_2024/dist/'
alias go-cd-nv='go-cd && nv'
alias go-v='cd ~/Documents/vinom/'
alias go-v-nv='go-v && nv'
alias sysup='sudo pacman -Syu && yay -Syu'


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
  if [ -z "$1" ]; then
      echo "Usage: ghotp <secret>"
      return 1
  fi
  oathtool --totp -b "$1"
}



# Function to set up a new servlet project
setup_servlet_project() {
  if [ -z "$1" ] || [ -z "$2" ]; then
      echo "Usage: setup_servlet_project <project_name> <project_id>"
      return 1
  fi

  local PROJECT_NAME=$1
  local PROJECT_ID=$2
  local PROJECT_DIR="./$PROJECT_NAME"
  local WEB_XML="$PROJECT_DIR/WEB-INF/web.xml"

  # Use $PROJECT_NAME and $PROJECT_ID as needed
  echo "Setting up project: $PROJECT_NAME with ID: $PROJECT_ID"

  # Create directory structure using Maven archetype
  echo "Creating project directory structure for $PROJECT_NAME..."
  mvn archetype:generate -DgroupId=com.example -DartifactId=$PROJECT_NAME -DarchetypeArtifactId=maven-archetype-webapp -DinteractiveMode=false

  # Move into the created project directory
  cd "$PROJECT_DIR" || { echo "Failed to enter directory $PROJECT_DIR"; return 1; }

  # Initialize git repository
  git init

  # Create Makefile
  touch Makefile
  cat > Makefile <<EOF
TARGET_DIR := target
WAR_NAME := $PROJECT_NAME-1.0-SNAPSHOT.war

.PHONY: build run test clean deploy

build:
	@mvn clean package

run:
	@mvn tomcat7:run

test:
	@mvn test

clean:
	@mvn clean
EOF

  echo "Commiting created files"
  git add .
  git commit -m "init project"
  echo "Commited created files"

  echo "Project $PROJECT_NAME created at $PROJECT_DIR."
  echo "Don't forget to add Tomcat 7 plugin to your pom.xml"
  
  # Display the Tomcat 7 plugin snippet for pom.xml
  echo "Paste this into your pom.xml:"
  cat <<'EOF'
    <plugins>
        <plugin>
            <groupId>org.apache.tomcat.maven</groupId>
            <artifactId>tomcat7-maven-plugin</artifactId>
            <version>2.2</version>
        </plugin>
    </plugins>
EOF
}

setup_go() {
  if [ -z "$1" ]; then
    echo "Usage: setup_go <project_name>"
    return 1
  fi

  PROJECT_NAME="$1"
  echo "Creating Go project with name $PROJECT_NAME"

  mkdir "$PROJECT_NAME" || { echo "Failed to create directory"; return 1; }
  cd "$PROJECT_NAME" || { echo "Failed to enter directory"; return 1; }

  go mod init "github.com/beka-birhanu/$PROJECT_NAME"

  git init

  touch Makefile
  cat > Makefile <<EOF
build:
	@go build -o ./bin/$PROJECT_NAME ./main.go

test:
	go test -v ./...

run: build
	@./bin/$PROJECT_NAME
EOF

  touch .gitignore
  cat > .gitignore <<EOF
bin
.env
tmp
EOF

  echo "Commiting created files"
  git add .
  git commit -m "init project"
  echo "Commited created files"

  echo "Your project is all set up with git, a Makefile containing basic commands, and Go modules initialized."
}
