# ~/.config/zsh/.zshrc
# History 
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt SHARE_HISTORY 
setopt HIST_IGNORE_DUPS 
setopt HIST_IGNORE_SPACE 
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

# Shell behavior 
setopt AUTOCD 
setopt NOBEEP 
setopt NUMERIC_GLOB_SORT

# Interactive menu completion 
zstyle ':completion:*' menu select
# Make completion case-insensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Zoxide
eval "$(zoxide init zsh)"

# fzf
if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then 
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
fi

# Modular config files

# Plugins 
source "$ZDOTDIR/plugins.zsh"

# Fzf 
source "$ZDOTDIR/fzf.zsh"

# Aliases 
source "$ZDOTDIR/aliases.zsh"

# Prompts
source "$ZDOTDIR/prompt.zsh"

# Bindings 
source "$ZDOTDIR/bindings.zsh"

