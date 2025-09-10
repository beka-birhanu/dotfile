# -------------------------
# History Configuration
# -------------------------
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
function zshaddhistory() { # I could start it with space, but I am STUPID with goldfish memory
    emulate -L zsh
    if [[ $1 = *"ghotp"* ]] ; then # avoid tracking github OTP command
        return 1
    fi
}
