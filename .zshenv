#==========================================================#
# 環境変数
#==========================================================#
# system-wide environment settings for zsh(1)
if [[ -x /usr/libexec/path_helper ]]; then
  eval `/usr/libexec/path_helper -s`
fi

if [[ -x "/usr/local/bin/brew" ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
  export HOMEBREW_BUNDLE_FILE=~/.config/brewfile/Brewfile
elif [[ -x /bin/bash && -d "/home/linuxbrew/.linuxbrew" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  export HOMEBREW_BUNDLE_FILE=~/.config/brewfile/Brewfile.linux
fi

if [[ -f "$HOME/.config/secrets" ]];then
  . "$HOME/.config/secrets"
fi

export EDITOR=nvim
