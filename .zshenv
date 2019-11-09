#==========================================================#
# 環境変数
#==========================================================#
# system-wide environment settings for zsh(1)
if [ -x /usr/libexec/path_helper ]; then
  eval `/usr/libexec/path_helper -s`
fi
export NODEBREW_ROOT=/usr/local/var/nodebrew
if [ -d "${NODEBREW_ROOT}" ]; then
  export PATH="${NODEBREW_ROOT}/current/bin:$PATH"
fi
export PATH="${HOME}/bin:$PATH"
eval "$(rbenv init -)"

if [ -d "$HOME/perl5" ]; then
  eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"
fi

export EDITOR=vim
export HOMEBREW_GITHUB_API_TOKEN=
