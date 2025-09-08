# -------------------------
# Powerlevel10k Instant Prompt
# -------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -------------------------
# Paths & Environment
# -------------------------
export BAT_THEME="Catppuccin Mocha"
export FD_COLOR="always"
export LS_COLORS="$(cat ~/.config/LS_COLORS)"

# -------------------------
# FZF Colors
# -------------------------
export FZF_DEFAULT_OPTS="
  --color=bg+:#1e1e2e,fg:#6c7086,header:#6c7086,info:#6c7086,pointer:#6c7086,marker:#6c7086,prompt:#6c7086,spinner:#6c7086,hl:#cba6f7,hl+:#cba6f7
"
