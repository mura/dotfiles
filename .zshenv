#==========================================================#
# 環境変数
#==========================================================#
# system-wide environment settings for zsh(1)
if [ -x /usr/libexec/path_helper ]; then
  eval `/usr/libexec/path_helper -s`
fi

if [ -x "/usr/local/bin/brew" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [ -d "/home/linuxbrew/.linuxbrew" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if [ -d "$HOMEBREW_PREFIX/opt/imagemagick@6" ]; then
  export PATH="$HOMEBREW_PREFIX/opt/imagemagick@6/bin:$PATH"
fi
if [ -d "$HOME/.anyenv" ]; then
  export PATH="$HOME/.anyenv/bin:$PATH"
fi
export PATH="$HOME/bin:$PATH"

if [ -f "$HOME/.config/secrets" ];then
  . "$HOME/.config/secrets"
fi

export EDITOR=nvim
