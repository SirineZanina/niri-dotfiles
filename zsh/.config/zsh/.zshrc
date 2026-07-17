# ~/.config/zsh/.zshrc — interactive shells only.
# Env + PATH live in .zshenv; this file is prompt, plugins, aliases, keybinds.

# ============================================================================
# ZINIT PLUGIN MANAGER
# ============================================================================

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [[ ! -d "$ZINIT_HOME" ]]; then
	mkdir -p "$(dirname "$ZINIT_HOME")"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Use the XDG compdump path from .zshenv; make sure its dir exists.
autoload -Uz compinit
[[ -d ${ZSH_COMPDUMP:h} ]] || mkdir -p ${ZSH_COMPDUMP:h}
compinit -C -d "$ZSH_COMPDUMP"

# ============================================================================
# PLUGINS
# ============================================================================

zinit light zsh-users/zsh-completions

zinit ice wait lucid; zinit light zsh-users/zsh-autosuggestions
zinit ice wait lucid; zinit light zsh-users/zsh-syntax-highlighting
zinit ice wait lucid atload"zicdreplay"; zinit light Aloxaf/fzf-tab

# Oh My Zsh snippets (deferred)
zinit ice wait lucid; zinit snippet OMZP::git
zinit ice wait lucid; zinit snippet OMZP::sudo
zinit ice wait lucid; zinit snippet OMZP::archlinux
#zinit ice wait lucid; zinit snippet OMZP::aws
#zinit ice wait lucid; zinit snippet OMZP::kubectl
#zinit ice wait lucid; zinit snippet OMZP::kubectx
zinit ice wait lucid; zinit snippet OMZP::command-not-found

# ============================================================================
# HISTORY (interactive sizing; HISTFILE itself is set in .zshenv)
# ============================================================================

HISTSIZE=1000000
SAVEHIST=1000000

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

setopt autocd                     # Type directory name to cd
setopt auto_param_slash           # Add trailing slash to completed dirs
setopt no_case_glob               # Case insensitive globbing
setopt no_case_match              # Case insensitive matching
setopt globdots                   # Include hidden files in glob
setopt extended_glob              # Extended globbing (~, #, ^)
setopt interactive_comments       # Allow comments in interactive shell

# Disable Ctrl-S freeze
stty stop undef

# ============================================================================
# COMPLETION STYLING
# ============================================================================

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-Z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes false

# FZF-tab completion preview
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# ============================================================================
# VI MODE
# ============================================================================

bindkey -v
export KEYTIMEOUT=1

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
# ALIASES
# ============================================================================

[[ -f "$ZDOTDIR/aliases.zsh" ]] && source "$ZDOTDIR/aliases.zsh"

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
# $ venv myvirtualenv   # activates venv
# $ deactivate
# $ rmvenv myvirtualenv # removes venv

export VENV_HOME="$HOME/.virtualenvs"
[[ -d "$VENV_HOME" ]] || mkdir -p "$VENV_HOME"

lsvenv() {
  ls -1 "$VENV_HOME"
}

venv() {
  if [[ $# -eq 0 ]]; then
    echo "Please provide venv name"
  else
    source "$VENV_HOME/$1/bin/activate"
  fi
}

mkvenv() {
  if [[ $# -eq 0 ]]; then
    echo "Please provide venv name"
  else
    python3 -m venv "$VENV_HOME/$1"
  fi
}

rmvenv() {
  if [[ $# -eq 0 ]]; then
    echo "Please provide venv name"
  else
    rm -r "$VENV_HOME/$1"
  fi
}

# ============================================================================
# JAVA VERSION SWITCHING
# ============================================================================

java-use() {
  local ver="${1:?Usage: java-use <21|25>}"
  sudo archlinux-java set "java-${ver}-openjdk"
  export JAVA_HOME="/usr/lib/jvm/java-${ver}-openjdk"
}

# ============================================================================
# BUN
# ============================================================================

# completions (BUN_INSTALL is exported in .zshenv)
[[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"

# ============================================================================
# FNM (lazy — only initializes on first use)
# ============================================================================

# Put the default node version's bin on PATH if it exists.
[[ -d "$FNM_DIR/aliases/default/bin" ]] && path=("$FNM_DIR/aliases/default/bin" $path)

fnm() {
  unfunction fnm
  eval "$(command fnm env --use-on-cd --shell zsh)"
  fnm "$@"
}

# ============================================================================
# UV
# ============================================================================

eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

# ============================================================================
# STARSHIP (MUST BE LAST)
# ============================================================================

eval "$(starship init zsh)"
