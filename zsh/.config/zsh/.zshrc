#   Zsh configuration
#   Plugins:      fast-syntax-highlighting, zsh-autosuggestions,
#                 zsh-history-substring-search, zsh-vi-mode
#   Prompt:       starship
#   Navigation:   zoxide, fzf, fd
#   CLI tools:    eza, bat, nvim, ripgrep
#   Node:         fnm

# --- History ---
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=100000   # entries kept in memory for this session
SAVEHIST=100000   # entries written to HISTFILE

# --- History: what gets recorded ---
setopt HIST_IGNORE_SPACE      # a leading space keeps a command out of history
setopt HIST_IGNORE_ALL_DUPS   # a repeated command removes its older copy
setopt HIST_SAVE_NO_DUPS      # never write duplicates to the file
setopt HIST_EXPIRE_DUPS_FIRST # when trimming, drop duplicates before uniques

# --- History: how it's stored and searched ---
setopt APPEND_HISTORY         # add to the file on exit, don't overwrite it
setopt SHARE_HISTORY          # live two-way sync between open shells
setopt HIST_FIND_NO_DUPS      # skip repeats when searching back

# --- Navigation ---
setopt AUTOCD                 # a bare directory name means cd there

# --- Globbing ---
setopt EXTENDED_GLOB          # enables the #, ^, ~ pattern operators
setopt GLOBDOTS               # globs match dotfiles without writing the dot
setopt NO_CASE_GLOB           # globs match regardless of case
setopt NUMERIC_GLOB_SORT      # sort file9 before file10, not after file1

# --- Interactive behaviour ---
setopt INTERACTIVE_COMMENTS   # # starts a comment at the prompt too
setopt AUTO_PARAM_SLASH       # completed directories get a trailing slash
setopt NOBEEP                 # no terminal bell

stty stop undef               # free ^S for ZLE (default: freeze the terminal)
stty start undef              # free ^Q for ZLE (default: unfreeze)


# =========================================================
# Completion
# =========================================================

ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump"
[[ -d ${ZSH_COMPDUMP:h} ]] || mkdir -p ${ZSH_COMPDUMP:h}

autoload -Uz compinit
if [[ -n $ZSH_COMPDUMP(N.mh+24) ]]; then
  compinit -d "$ZSH_COMPDUMP"      # full rescan, once a day
else
  compinit -C -d "$ZSH_COMPDUMP"   # trust the cache
fi
[[ $ZSH_COMPDUMP.zwc -nt $ZSH_COMPDUMP ]] || zcompile -R -- "$ZSH_COMPDUMP" &!


# Initialize zoxide
eval "$(zoxide init --cmd cd zsh)"

_lscolors="$XDG_CACHE_HOME/zsh/ls_colors.zsh"
[[ -r $_lscolors ]] || { mkdir -p ${_lscolors:h}; dircolors -b >| $_lscolors }
source $_lscolors
unset _lscolors

# Enable interactive completion menu selection
zstyle ':completion:*' menu select

# Make completion case-insensitive
# Example: "doc" can complete to "Documents"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes false


# =========================================================
# Fuzzy finder
# =========================================================
if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
fi

# =========================================================
# Bun / FNM / Python VENV / java-use
# =========================================================

[[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"

# fnm, lazily — the real env is only evaluated on first fnm call
[[ -d "$FNM_DIR/aliases/default/bin" ]] && path=("$FNM_DIR/aliases/default/bin" $path)
fnm() {
  unfunction fnm
  eval "$(command fnm env --use-on-cd --shell zsh)"
  fnm "$@"
}

# --- Python venvs ---
# mkvenv NAME / venv NAME / deactivate / rmvenv NAME
export VENV_HOME="$HOME/.virtualenvs"
[[ -d "$VENV_HOME" ]] || mkdir -p "$VENV_HOME"

lsvenv() { ls -1 "$VENV_HOME" }
venv()   { source "$VENV_HOME/${1:?venv name required}/bin/activate" }
mkvenv() { python3 -m venv "$VENV_HOME/${1:?venv name required}" }
rmvenv() { rm -rI "$VENV_HOME/${1:?venv name required}" }


# --- Java version switching ---
# JAVA_HOME points at /usr/lib/jvm/default in .zshenv — the symlink this updates.
java-use() {
  local ver="${1:?Usage: java-use <21|25>}"
  sudo archlinux-java set "java-${ver}-openjdk"
}

# --- Yazi Setup ---
function y(){
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}
# =========================================================
# Modular Config Files
# =========================================================

source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/fzf.zsh"        # FZF_* vars only
source "$ZDOTDIR/plugins.zsh"    # zvm inits here, during sourcing

source "$ZDOTDIR/bindings.zsh"   # plain bindkeys, no hook
source "$ZDOTDIR/prompt.zsh"
