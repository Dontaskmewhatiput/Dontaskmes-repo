## Better ls
alias ls='eza --icons auto'

# Detailed listing
alias ll='eza -lh --icons --git'

# Full listing
alias lla='eza -lha --icons --git'

# Tree view
alias tree='eza --tree --icons auto'

# Better cat
alias cat='bat'

# =========================================================
# Core utilities
# =========================================================

alias grep='rg --color=auto'
alias diff='diff --color=auto'
alias df='df -h'

# =========================================================
# Navigation
# =========================================================

alias -- -='cd -'  # -- prevents - being parsed as a flag; cd - jumps to previous directory

lf() { # zsh follow lf navigation
    tmp=$(mktemp)
    command lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir=$(cat "$tmp")
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}



# =========================================================
# Editor
# =========================================================

alias vim='nvim'
alias svi='sudo -E nvim '

# =========================================================
# Git
# =========================================================

alias glog='PAGER="less -F -X" git log'                              # -F quit if one screen, -X no clear on exit
alias gadog='PAGER="less -F -X" git log --all --decorate --oneline --graph'
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias gl='git pull '
alias gp='git push '
alias gc='git commit '
alias ga='git add '

# =========================================================
# Video
# =========================================================
alias stream='mpv av://v4l2:/dev/video4 --fullscreen --demuxer-lavf-o=input_format=mjpeg,framerate=60 --profile=low-latency --untimed'

# =========================================================
# Pacman
# =========================================================
alias install='pacman -S'
alias aur='paru'
alias pacrmcache='sudo pacman -Scc'
alias pacquery='pacman -Qi'
alias paclocs='pacman -Qs'
alias pacrem='sudo pacman -Rns'
alias pacrmorphans='sudo pacman -Rs $(pacman -Qtdq)'
alias aurora="parui"
alias pacs='pacman -Ss'

# =========================================================
# System utilities
# =========================================================
alias mirrors="reflector -p https --latest 25 --country US --age 2 --threads 16 --download-timeout 30 --connection-timeout 20 --sort rate --save /etc/pacman.d/mirrorlist "
alias top='btop'
alias ff='fastfetch'

# =========================================================
# General use
# =========================================================
alias ex='exit'
