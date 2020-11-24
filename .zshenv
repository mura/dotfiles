#==========================================================#
# 環境変数
#==========================================================#
# system-wide environment settings for zsh(1)
if [ -x /usr/libexec/path_helper ]; then
  eval `/usr/libexec/path_helper -s`
fi

if [ -d "/usr/local/opt/imagemagick@6" ]; then
  export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
fi
if [ -d "$HOME/.anyenv" ]; then
  export PATH="$HOME/.anyenv/bin:$PATH"
fi
export PATH="$HOME/bin:$PATH"

if [ -d "$HOME/perl5" ]; then
  eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"
fi

if [ -f "$HOME/.config/secrets" ];then
  . "$HOME/.config/secrets"
fi

# for Homebrew env
if type "brew" >/dev/null 2>&1; then
  export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
fi

export EDITOR=nvim
