# Google Cloud SDK
if [[ -d "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk" ]]; then
  source "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
fi

if [[ -d "$HOME/.anyenv" ]]; then
  export PATH="$HOME/.anyenv/bin:$PATH"
fi

export PATH="$HOME/.local/bin:$PATH"

# anyenv
if type "anyenv" >/dev/null 2>&1; then
  eval "$(anyenv init -)"
fi

typeset -U PATH
