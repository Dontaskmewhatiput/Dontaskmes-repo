# /etc/nixos/modules/zsh/aliases.zsh

alias ls='eza --icons auto'
alias ll='eza -lh --icons --git'
alias lla='eza -lha --icons --git'
alias tree='eza --tree --icons auto'
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
# Nix
# =========================================================

alias nrs='sudo nixos-rebuild switch --flake'
alias nixs='nix search nixpkgs '
alias nixgarbage='sudo nix-collect-garbage -d'

# =========================================================
# System utilities
# =========================================================
alias top='btop'
alias ff='fastfetch'

# =========================================================
# General use
# =========================================================
alias ex='exit'
alias soft-reboot='systemctl soft-reboot'
