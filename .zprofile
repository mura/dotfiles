if [ -d "$HOMEBREW_PREFIX/opt/imagemagick@6" ]; then
  export PATH="$HOMEBREW_PREFIX/opt/imagemagick@6/bin:$PATH"
fi

if [ -d "$HOME/.anyenv" ]; then
  export PATH="$HOME/.anyenv/bin:$PATH"
fi

export PATH="$HOME/.local/bin:$PATH"

# anyenv
if $(command -v anyenv >/dev/null); then
  eval "$(anyenv init -)"
fi
