# /etc/nixos/modules/zsh/options.zsh
HISTFILE="$HOME/.local/state/zsh/history"
HISTSIZE=50000
SAVEHIST=50000
mkdir -p "${HISTFILE:h}"

setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY
setopt AUTO_CD INTERACTIVE_COMMENTS
unsetopt beep
