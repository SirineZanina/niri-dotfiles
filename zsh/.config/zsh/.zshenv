# ~/.config/zsh/.zshenv — environment for ALL zsh invocations
# (login, non-login, interactive, scripts). Env + PATH belong here.

# ============================================================================
# XDG BASE DIRECTORIES
# ============================================================================
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# Colored ls / completion / fzf-tab — populate LS_COLORS from dircolors defaults
[[ -z "$LS_COLORS" ]] && eval "$(dircolors -b)"

# ============================================================================
# DEFAULT APPLICATIONS
# ============================================================================
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="kitty"
export BROWSER="brave"
export PAGER="less"

# ============================================================================
# PATH
# ============================================================================
# Dedupe automatically: keeps first occurrence, so nested shells never stack
# duplicate entries even though this file runs for every zsh.
typeset -U path PATH

# Tool homes (define before referencing in PATH)
export JAVA_HOME="/usr/lib/jvm/java-25-openjdk"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export GOPATH="$XDG_DATA_HOME/go"
export GOBIN="$GOPATH/bin"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"
export DOTNET_ROOT="$HOME/.dotnet"
export BUN_INSTALL="$HOME/.bun"
export FNM_DIR="$XDG_DATA_HOME/fnm"

# Only add dirs that actually exist, so PATH stays free of dead entries.
for dir in \
  "$HOME/.local/bin" \
  "$XDG_CONFIG_HOME/scripts" \
  "$JAVA_HOME/bin" \
  "$CARGO_HOME/bin" \
  "$GOBIN" \
  "$DOTNET_ROOT" "$DOTNET_ROOT/tools" \
  "$BUN_INSTALL/bin" \
  "$FNM_DIR"
do
  [[ -d $dir ]] && path=("$dir" $path)
done
unset dir

# ============================================================================
# XDG-COMPLIANT APP CONFIGS / HISTORY
# ============================================================================
export HISTFILE="$XDG_STATE_HOME/zsh/history"
[[ -d ${HISTFILE:h} ]] || mkdir -p ${HISTFILE:h}

export LESSHISTFILE="$XDG_STATE_HOME/less_history"
export PYTHON_HISTORY="$XDG_STATE_HOME/python_history"
export NODE_REPL_HISTORY="$XDG_STATE_HOME/node_repl_history"

export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"

export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/.zcompdump"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/ssh-agent.socket"
export TMPDIR="$XDG_CACHE_HOME/tmp"

# Java: keep prefs out of ~ , fix GUI apps under tiling WMs
export JDK_JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"
export _JAVA_AWT_WM_NONREPARENTING=1

# ============================================================================
# FZF
# ============================================================================
export FZF_DEFAULT_OPTS="--layout=reverse --height=40% --border --color=16"
export FZF_CTRL_R_OPTS="--no-sort --exact --preview='echo {}' --preview-window=down:3:wrap"
export FZF_ALT_C_OPTS="--preview='ls --color=always {}'"

# ============================================================================
# LESS / MAN PAGE COLORS
# ============================================================================
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export LESS="-R --use-color -Dd+r -Du+b"

# $'...' embeds real ESC chars (the plain-string version was missing them).
export LESS_TERMCAP_mb=$'\e[1;31m'      # begin blinking
export LESS_TERMCAP_md=$'\e[1;36m'      # begin bold
export LESS_TERMCAP_me=$'\e[0m'         # end mode
export LESS_TERMCAP_so=$'\e[01;44;33m'  # begin standout
export LESS_TERMCAP_se=$'\e[0m'         # end standout
export LESS_TERMCAP_us=$'\e[1;32m'      # begin underline
export LESS_TERMCAP_ue=$'\e[0m'         # end underline

# ============================================================================
# MISC
# ============================================================================
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"

# Env-type secrets (gitignored). Interactive-only secrets can move to .zshrc.
[[ -f "$ZDOTDIR/secrets.zsh" ]] && source "$ZDOTDIR/secrets.zsh"
