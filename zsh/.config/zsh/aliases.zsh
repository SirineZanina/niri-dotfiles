# ~/.config/zsh/aliases.zsh — interactive aliases, sourced by .zshrc

# ============================================================================
# NAVIGATION
# ============================================================================
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias home='cd ~'
alias config='cd ~/.config'
alias downloads='cd ~/Downloads'
alias documents='cd ~/Documents'

# ============================================================================
# LS VARIANTS
# ============================================================================
alias ls='eza --color=auto --group-directories-first'
alias ll='eza -lh --color=auto --group-directories-first'
alias la='eza -lah --color=auto --group-directories-first'
alias l='eza --color=auto'
alias lt='eza -lh --sort=modified --color=auto'
alias ltr='eza -lh --sort=modified --reverse --color=auto'
alias lsize='eza -lh --sort=size --color=auto'
alias tree='eza --tree --color=auto'

# ============================================================================
# SAFETY NETS
# ============================================================================
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# ============================================================================
# COMMON SHORTCUTS
# ============================================================================
alias c='clear'
alias h='history'
alias v='nvim'
alias vim='nvim'
alias vi='nvim'
alias e='$EDITOR'

# ============================================================================
# GREP WITH COLOR
# ============================================================================
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# ============================================================================
# SYSTEM INFORMATION
# ============================================================================
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias ports='ss -tulanp'
alias myip='curl -s ifconfig.me'
alias localip='ip -4 addr show | grep inet'

# ============================================================================
# PROCESS MANAGEMENT
# ============================================================================
alias ps='ps auxf'
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e'
alias topcpu='ps aux --sort=-%cpu | head -11'
alias topmem='ps aux --sort=-%mem | head -11'

# ============================================================================
# ARCH LINUX PACKAGE MANAGEMENT
# ============================================================================
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias remove='sudo pacman -Rns'
alias search='pacman -Ss'
alias pkginfo='pacman -Qi'
alias orphans='sudo pacman -Rns $(pacman -Qtdq)'
alias cleanup='sudo pacman -Sc && paccache -rk1'
alias mirrors='sudo reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist'

# ============================================================================
# GIT SHORTCUTS
# ============================================================================
alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gl='git log --oneline --graph --decorate --all'
alias gd='git diff'
alias gdc='git diff --cached'
alias gb='git branch'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gclean='git clean -fd'

# ============================================================================
# CONFIG FILE SHORTCUTS
# ============================================================================
alias zshrc='$EDITOR $ZDOTDIR/.zshrc'
alias zshenv='$EDITOR $ZDOTDIR/.zshenv'
alias aliases='$EDITOR $ZDOTDIR/aliases.zsh'
alias secrets='$EDITOR $ZDOTDIR/secrets.zsh'
alias nvimrc='$EDITOR ~/.config/nvim/init.lua'
alias niriconf='$EDITOR ~/.config/niri/config.kdl'

# Reload interactive config. Note: env/PATH changes in .zshenv need a fresh
# shell (exec zsh) — this only re-runs .zshrc.
alias reload='source $ZDOTDIR/.zshrc && echo "zsh config reloaded"'

# ============================================================================
# DIRECTORY OPERATIONS
# ============================================================================
alias mkdir='mkdir -pv'

# ============================================================================
# FILE OPERATIONS
# ============================================================================
alias diff='diff --color=auto'
alias tree='tree -C'
alias findhere='find . -name'
alias count='find . -type f | wc -l'

# ============================================================================
# NETWORK
# ============================================================================
alias ping='ping -c 5'
alias wget='wget -c'
alias speedtest='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -'

# ============================================================================
# SYSTEM UTILITIES
# ============================================================================
alias timestamp='date +%Y%m%d_%H%M%S'
alias now='date +"%Y-%m-%d %H:%M:%S"'
alias weather='curl wttr.in'
alias cheat='curl cheat.sh'

# ============================================================================
# MISC
# ============================================================================
alias path='echo $PATH | tr ":" "\n"'
alias histg='history | grep'
alias extract='tar -xvf'
alias archive='tar -czvf'
