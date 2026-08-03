# ~/.config/zsh/.zshenv

# --- XDG base directories ---
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# --- Executable temp dir (system /tmp is noexec) ---
export TMPDIR="$XDG_CACHE_HOME/tmp"
[[ -d "$TMPDIR" ]] || mkdir -p "$TMPDIR"

# --- Default applications ---
export EDITOR="nvim"     # fallback editor for tools that ignore VISUAL
export VISUAL="nvim"     # preferred editor; git, sudoedit, crontab read this first
export TERMINAL="kitty"  # read by some WMs and desktop launchers
export BROWSER="brave"   # read by xdg-open fallbacks and CLI tools

# --- PATH ---
# Dedupe automatically: keeps first occurrence, so nested shells never stack
# duplicate entries even though this file runs for every zsh.
typeset -U path PATH

# Tool homes — define before referencing them in the loop below.
export JAVA_HOME=/usr/lib/jvm/default   # symlink that archlinux-java updates
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export GOPATH="$XDG_DATA_HOME/go"
export DOTNET_ROOT="$HOME/.dotnet"
export BUN_INSTALL="$HOME/.bun"
export FNM_DIR="$XDG_DATA_HOME/fnm"

# Only add dirs that actually exist, so PATH stays free of dead entries.
# Each iteration prepends, so the LAST entry below ends up first in PATH.
for dir in \
  "$BUN_INSTALL/bin" \
  "$DOTNET_ROOT" \
  "$GOPATH/bin" \
  "$CARGO_HOME/bin" \
  "$HOME/.local/bin"
do
  [[ -d $dir ]] && path=("$dir" $path)
done
unset dir

# ---------- Pager ----------
export MANPAGER="bat -l man -p"

# ---------- GPG ----------
export GPG_TTY=$(tty)

# --- Keeping other tools' state out of $HOME ---
export LESSHISTFILE="$XDG_STATE_HOME/less_history"
export PYTHON_HISTORY="$XDG_STATE_HOME/python_history"      # Python 3.13+ only
export NODE_REPL_HISTORY="$XDG_STATE_HOME/node_repl_history"

export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"     # sourced by the REPL
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"

# Agent socket — assumes systemd's ssh-agent.socket user unit is enabled.
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/ssh-agent.socket"

# --- Java quirks ---
export JDK_JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"  # prefs out of $HOME
export _JAVA_AWT_WM_NONREPARENTING=1                                        # fixes GUI apps under tiling WMs

# --- Misc ---
export STARSHIP_CONFIG="$ZDOTDIR/starship.toml"

# Env-type secrets (gitignored). Interactive-only secrets can move to .zshrc.
[[ -f "$ZDOTDIR/secrets.zsh" ]] && source "$ZDOTDIR/secrets.zsh"
