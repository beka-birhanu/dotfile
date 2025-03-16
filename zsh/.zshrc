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

# Syntax Highlighting, Autosuggestions, and Completions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

# History Configuration
zinit ice lucid wait'0'
zinit light joshskidmore/zsh-fzf-history-search
#
HISTSIZE=1000
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history
HISTDUP=erase # Erase duplicates in the history file
setopt append_history # Append history to the history file
setopt share_history # Share history between all sessions
setopt hist_ignore_space # Ignore commands that start with a space
setopt hist_ignore_dups # Ignore duplication command history line
setopt hist_ignore_all_dups # Ignore all duplication command history line
setopt hist_save_no_dups # Do not save duplication command history line
setopt hist_find_no_dups # Do not find duplication command history line
function zshaddhistory() { # I could start it with space, but I am not willing to take the chance of forgetting.
    emulate -L zsh
    if [[ $1 = *"ghotp"* ]] ; then # avoid tracking github OTP command
        return 1
    fi
}

# Completion System
autoload -Uz compinit && compinit
ENABLE_CORRECTION="true"
#
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
#
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Aliases
alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias src='source ~/.zshrc'
alias fcd='cd $(find . -type d | fzf --preview "tree -C {} | head -50")'
alias nv='nvim'
alias fnv='nv $(fzf --preview "cat {}")'
alias fdnv='fcd && nv'
alias sysup='sudo pacman -Syu --noconfirm && yay -Syu --noconfirm'
alias kp="ps aux | fzf | awk '{print \$2}' | xargs kill -9"
alias ta='eval tmux attach -t "$(tmux list-sessions | awk -F':' '"'"'{print $1}'"'"' | fzf)"'

# Keybindings
bindkey '^j' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
#
bindkey '^[[1;5C' forward-word      # Ctrl + → (Right)
bindkey '^[[1;5D' backward-word     # Ctrl + ← (Left)
zinit light jirutka/zsh-shift-select
#
bindkey '^[[1~' beginning-of-line    # Home
bindkey '^[[4~' end-of-line          # End
#
bindkey '^?' backward-delete-char   # Backspace
bindkey '^[[3~' delete-char         # Delete

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


# project setups
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
#
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
