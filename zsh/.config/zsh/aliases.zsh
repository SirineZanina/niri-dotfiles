# ~/.config/zsh/aliases.zsh — interactive aliases, sourced by .zshrc


# --- ls, via eza ---
# NOTE: eza v0.23+ changed --icons to take an optional value (--icons [WHEN]).
# Use --icons=auto (identical to the old bare --icons) so that the first
# positional argument is still parsed as a path, e.g. `ls .git/`.
alias ls='eza --icons=auto'
alias ll='eza -lh --icons=auto --git'    # long listing with git status column
alias la='eza -lah --icons=auto --git'   # same, including dotfiles
alias tree='eza --tree --icons=auto'

# Give eza ls's completions rather than writing a separate _eza.
compdef eza=ls


# --- Modern replacements ---
alias cat='bat'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias df='df -h'                    # sizes in K/M/G instead of raw blocks

alias rm='rm -i'

# --- Navigation ---
# -- stops zsh parsing the - as a flag; cd - returns to the previous directory.
alias -- -='cd -'


# --- Editor ---
alias v='nvim'
alias vim='nvim'


# --- Git ---
# -F exits if output fits one screen, -X leaves it on-screen after quitting.
alias glog='PAGER="less -F -X" git log'
alias gadog='PAGER="less -F -X" git log --all --decorate --oneline --graph'


# --- Safety nets: prompt before clobbering or deleting ---
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'


# --- Shortcuts ---
alias c='clear'
