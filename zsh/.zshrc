# =============================================================================
# ZSH Configuration — zinit + starship
# =============================================================================

# ---------------------
# History
# ---------------------
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS  # no duplicate entries
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY         # share history across sessions
setopt APPEND_HISTORY

# ---------------------
# General options
# ---------------------
setopt AUTO_CD               # cd by typing directory name
setopt CORRECT               # command auto-correction
setopt NO_BEEP

# ---------------------
# Vi mode
# ---------------------
bindkey -v
export KEYTIMEOUT=1          # reduce mode switch delay (10ms)

# ---------------------
# PATH
# ---------------------
export PATH="/opt/homebrew/opt/python@3.12/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# ---------------------
# Editor
# ---------------------
export EDITOR='nvim'
export VISUAL='nvim'

# ---------------------
# Zinit
# ---------------------
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

# Auto-install zinit if missing
if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"

# ---------------------
# Plugins
# ---------------------
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions

# Load completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# ---------------------
# fzf
# ---------------------
if command -v fzf &>/dev/null; then
  source <(fzf --zsh)
fi

# ---------------------
# Yazi wrapper (cd to last dir on quit)
# ---------------------
function rr() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# ---------------------
# Aliases
# ---------------------
alias v="nvim"
alias ll="ls -la"
alias gs="git status"
alias gd="git diff"
alias gl="git log --oneline --graph"

# ---------------------
# Starship prompt (keep at end)
# ---------------------
eval "$(starship init zsh)"
