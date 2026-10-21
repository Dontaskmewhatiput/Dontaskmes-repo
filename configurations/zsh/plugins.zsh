# ~/.config/zsh/plugins.zsh
ZPLUGINDIR="${ZDOTDIR:-$HOME/.config/zsh}/plugins"

_zplugin_load() {
  local plugin_path="${ZPLUGINDIR}/${2}"
  if [[ ! -d "$plugin_path" ]]; then
    mkdir -p "$ZPLUGINDIR"
    echo "Installing ${2}..."
    git clone --depth=1 "https://github.com/${1}/${2}" "$plugin_path" \
      || { echo "ERROR: failed to install ${2}" >&2; return 1; }
  fi
  # Try .plugin.zsh first, fall back to .zsh
  if [[ -f "${plugin_path}/${2}.plugin.zsh" ]]; then
    source "${plugin_path}/${2}.plugin.zsh"
  else
    source "${plugin_path}/${2}.zsh"
  fi
}

zplugin-update() {
  local dir
  for dir in "${ZPLUGINDIR}"/*/; do
    echo "Updating ${dir:t}..."
    git -C "$dir" pull --ff-only
  done
}

# Built-in vi mode (replaces zsh-vi-mode)
bindkey -v

# zsh-autocomplete must load first
_zplugin_load marlonrichert zsh-autocomplete

# Preload zasync outside the line editor
for _zasync in \
  "${XDG_DATA_HOME:-$HOME/.local/share}/zasync/zasync" \
  "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zasync/zasync"; do
  if [[ -f $_zasync ]]; then
    autoload -Uz "$_zasync"
    zasync help >/dev/null 2>&1
    break
  fi
done
unset _zasync

zstyle ':autocomplete:*' min-input 1
zstyle ':autocomplete:*' delay 0.05
zstyle ':autocomplete:*' list-lines 10

_zplugin_load zsh-users zsh-history-substring-search
_zplugin_load michaelaquilina zsh-you-should-use
_zplugin_load zsh-users zsh-autosuggestions

# Must load last
_zplugin_load zsh-users zsh-syntax-highlighting
