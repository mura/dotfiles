#==========================================================#
# 環境変数
#==========================================================#
# system-wide environment settings for zsh(1)
if [ -x /usr/libexec/path_helper ]; then
  eval `/usr/libexec/path_helper -s`
fi
export PATH="${HOME}/bin:$PATH"

export EDITOR=vim
export HOMEBREW_GITHUB_API_TOKEN=
