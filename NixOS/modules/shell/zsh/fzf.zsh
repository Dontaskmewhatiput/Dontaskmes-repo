# /etc/nixos/modules/zsh/fzf.zsh
export FZF_DEFAULT_OPTS='--height=40% --layout=reverse --border'
source <(fzf --zsh)
eval "$(zoxide init zsh)"
