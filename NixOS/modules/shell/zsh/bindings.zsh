# /etc/nixos/modules/zsh/bindings.zsh
export KEYTIMEOUT=1

# Cursor shape: beam in insert mode, block in normal mode
_cursor_shape() {
  case $KEYMAP in
    vicmd) print -n '\e[2 q' ;;
    *)     print -n '\e[6 q' ;;
  esac
}
zle-keymap-select() { _cursor_shape }
zle-line-init() { _cursor_shape }
zle -N zle-keymap-select
zle -N zle-line-init

# Ctrl+Left and Ctrl+Right move by word
bindkey -M viins '^[[1;5C' forward-word
bindkey -M viins '^[[1;5D' backward-word

# Ctrl+\ toggles autosuggestions
bindkey -M viins '^\' autosuggest-toggle
