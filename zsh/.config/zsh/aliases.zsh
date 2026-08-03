# ~/.config/zsh/aliases.zsh — interactive aliases, sourced by .zshrc


# --- ls, via eza ---
alias ls='eza --icons'
alias ll='eza -lh --icons --git'    # long listing with git status column
alias la='eza -lah --icons --git'   # same, including dotfiles
alias tree='eza --tree --icons'

# Give eza ls's completions rather than writing a separate _eza.
compdef eza=ls


# --- Modern replacements ---
alias cat='bat'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias df='df -h'                    # sizes in K/M/G instead of raw blocks


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
