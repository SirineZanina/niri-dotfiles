# Source shared profile if not already sourced
[ -z "$XDG_CONFIG_HOME" ] && [ -f "$HOME/.config/shell/profile" ] && source "$HOME/.config/shell/profile"

# ============================================================================
# ZINIT PLUGIN MANAGER
# ============================================================================

# Set Zinit home directory
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit if not present
if [ ! -d "$ZINIT_HOME" ]; then 
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load Zinit
source "${ZINIT_HOME}/zinit.zsh"

# ============================================================================
# PLUGINS
# ============================================================================

# Zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Oh My Zsh snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# ============================================================================
# COMPLETIONS
# ============================================================================

# Load completions
autoload -U compinit && compinit -d "$ZSH_COMPDUMP"
autoload -U colors && colors
zinit cdreplay -q

# ============================================================================
# HISTORY CONFIGURATION
# ============================================================================

HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE="$XDG_STATE_HOME/zsh/history"

# History options
setopt appendhistory              # Append to history file
setopt sharehistory               # Share history across sessions
setopt hist_ignore_space          # Ignore commands starting with space
setopt hist_ignore_all_dups       # Remove older duplicate entries
setopt hist_save_no_dups          # Don't save duplicate entries
setopt hist_ignore_dups           # Ignore consecutive duplicates
setopt hist_find_no_dups          # Don't show duplicates in search
setopt inc_append_history         # Add commands immediately

# ============================================================================
# ZSH OPTIONS
# ============================================================================

# General options
setopt autocd                     # Type directory name to cd
setopt auto_param_slash           # Add trailing slash to completed dirs
setopt no_case_glob               # Case insensitive globbing
setopt no_case_match              # Case insensitive matching
setopt globdots                   # Include hidden files in glob
setopt extended_glob              # Extended globbing (~, #, ^)
setopt interactive_comments       # Allow comments in interactive shell
# unsetopt prompt_sp                # Don't auto-clean blank lines

# Disable Ctrl-S freeze
stty stop undef

# ============================================================================
# COMPLETION STYLING
# ============================================================================

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-Z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes false

# FZF-tab completion preview
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# ============================================================================
# VI MODE
# ============================================================================

bindkey -v
export KEYTIMEOUT=1

# Vi mode cursor shape
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'  # Block cursor for normal mode
  elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'  # Beam cursor for insert mode
  fi
}

zle -N zle-keymap-select

function zle-line-init {
  echo -ne '\e[5 q'  # Start with beam cursor
}

# Initialize cursor on shell start
echo -ne '\e[5 q'

# ============================================================================
# KEYBINDINGS
# ============================================================================

# Vi mode history navigation (in normal mode)
bindkey -M vicmd 'k' up-line-or-history
bindkey -M vicmd 'j' down-line-or-history

# Ctrl+P/N for history (in insert mode)
bindkey -M viins '^P' up-line-or-history
bindkey -M viins '^N' down-line-or-history

# History search
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^r' fzf-history-widget

# Emacs-style line editing (works in vi insert mode)
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^k' kill-line
bindkey '^u' backward-kill-line
bindkey '^w' backward-kill-word

# ============================================================================
# SOURCE SHARED CONFIGS
# ============================================================================

# Source shared aliases (from ~/.config/shell/alias)
[ -f "$HOME/.config/shell/alias" ] && source "$HOME/.config/shell/alias"

# ============================================================================
# SHELL INTEGRATIONS
# ============================================================================

# FZF (fuzzy finder)
eval "$(fzf --zsh)"

# Zoxide (better cd)
eval "$(zoxide init --cmd cd zsh)"

# ============================================================================
# PYTHON VENVS
# ============================================================================

# usage 
# $ mkvenv myvirtualenv # creates venv under ~/.virtualenvs/
# $ venv myvirtualenv # activates venv
# $ deactivate
# $ rmvenv myvirtualenv # removes venv

export VENV_HOME="$HOME/.virtualenvs"

[[ -d $VENV_HOME ]] || mkdir $VENV_HOME

lsvenv(){
  ls -1 $VENV_HOME
}

venv() {
  if [ $# -eq 0 ]
  then 
    echo "Please provide venv name"
  else 
    source "$VENV_HOME/$1/bin/activate"
  fi
}

mkvenv() {
  if [ $# -eq 0 ]
  then 
    echo "Please provide venv name"
  else
    python3 -m venv $VENV_HOME/$1
  fi
}

rmvenv() {
  if [ $# -eq 0 ]
  then
    echo "Please provide venv name"
  else
    rm -r $VENV_HOME/$1
  fi
}

# ============================================================================
# BUN
# ============================================================================

# bun completions
[ -s "/home/sirine/.bun/_bun" ] && source "/home/sirine/.bun/_bun"

# ============================================================================
# FNM (must be before oh-my-posh)
# ============================================================================

# Ensure fnm shims take priority over any system Node (/usr/bin/node)
export PATH="$FNM_DIR/aliases/default/bin:$PATH"
eval "$(fnm env --use-on-cd --shell zsh)"

# ============================================================================
# OH MY POSH (MUST BE LAST)
# ============================================================================

eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
