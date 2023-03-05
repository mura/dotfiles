# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
bindkey -e
# End of lines configured by zsh-newuser-install

###
# Set shell options
###
setopt auto_cd              # コマンドが省略されていたら cd とみなす
setopt auto_pushd           # cd 時にOldDir を自動的にスタックに積む
setopt correct              # コマンドのスペルチェック
setopt auto_name_dirs       # ~で始まるディレクトリを絶対パスにする
setopt auto_remove_slash    # 補完が/で終って、つぎが、語分割子か/かコマンド
                            # の後(; とか & )だったら、補完末尾の/を取る
setopt extended_history     # ヒストリに時刻情報もつける
setopt extended_glob        # グロブで、特殊文字"#,~,^"を使う、
setopt function_argzero     # $0 にスクリプト名/シェル関数名を格納

setopt hist_ignore_dups     # 前のコマンドと同じならヒストリに入れない
setopt hist_ignore_space    # 空白ではじまるコマンドをヒストリに保持しない
setopt hist_ignore_all_dups # 重複するヒストリを持たない
setopt hist_no_functions    # 関数定義をヒストリに入れない
setopt hist_no_store        # history コマンドをヒストリに入れない
setopt hist_reduce_blanks   # 履歴から冗長な空白を除く
setopt multios              # 名前付きパイプ的に入出力を複数開ける
setopt numeric_glob_sort    # グロブの数のマッチを辞書式順じゃなくって数値の順
setopt prompt_subst         # プロンプト文字列で各種展開を行なう
setopt no_promptcr          # 改行コードで終らない出力もちゃんと出力する
setopt pushd_ignore_dups    # ディレクトリスタックに、同じディレクトリを入れない
setopt share_history        # 複数プロセスで履歴を共有
setopt short_loops          # loop の短縮形を許す
setopt rc_expand_param      # {}をbash ライクに展開
setopt transient_rprompt    # 右プロンプトに入力がきたら消す
setopt null_glob            # グロブがマッチしないときエラーにしない
#setopt ignore_eof           # Ctrl-D でログアウトするのを抑制する。
#setopt xtrace               # デバッグ用 コマンドラインがどのように展開されたか表示

###
# Homebrew
###
if [[ -x "/usr/local/bin/brew" ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
  export HOMEBREW_BUNDLE_FILE=~/.config/brewfile/Brewfile
elif [[ -x /bin/bash && -d "/home/linuxbrew/.linuxbrew" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  export HOMEBREW_BUNDLE_FILE=~/.config/brewfile/Brewfile.linux
fi

###
# PATH
###
export PATH="$HOME/.local/bin:$PATH"
if [[ -d "$HOME/.anyenv" ]]; then
  export PATH="$HOME/.anyenv/bin:$PATH"
fi

typeset -gU PATH

###
# zplug
###
if [[ -n "$HOMEBREW_PREFIX" && -d "$HOMEBREW_PREFIX/opt/zplug" ]]; then
  # Homebrew
  export ZPLUG_HOME="$HOMEBREW_PREFIX/opt/zplug"
  source $ZPLUG_HOME/init.zsh
elif [[ -d "/usr/share/zplug" ]]; then
  # Ubuntu
  export ZPLUG_HOME=~/.zplug
  source /usr/share/zplug/init.zsh
elif [[ -d "/usr/share/zsh/scripts/zplug" ]]; then
  # Arch
  export ZPLUG_HOME=~/.zplug
  source /usr/share/zsh/scripts/zplug/init.zsh
elif [[ -f ~/.zplug/init.zsh ]]; then
  # Manual
  export ZPLUG_HOME=~/.zplug
  source $ZPLUG_HOME/init.zsh
fi

###
# zsh plugins
###
_powerlevel10k_path() {
  if [[ -n "$HOMEBREW_PREFIX" && -d "$HOMEBREW_PREFIX/opt/powerlevel10k" ]]; then
    echo "$HOMEBREW_PREFIX/opt/powerlevel10k"
  fi
}
_plugin_path () {
  name=$1
  if [[ -n "$HOMEBREW_PREFIX" && -d "$HOMEBREW_PREFIX/share/$name" ]]; then
    echo "$HOMEBREW_PREFIX/share/$name"
  elif [[ -d "/usr/share/$name" ]]; then
    echo "/usr/share/$name"
  fi
}

if [[ -n "$(command -v zplug)" ]]; then
  if [[ -z "$(_powerlevel10k_path)" ]]; then
    zplug 'romkatv/powerlevel10k', as:theme, depth:1
  fi
  if [[ -z "$(_plugin_path zsh-completions)" ]]; then
    zplug 'zsh-users/zsh-completions'
  fi
  if [[ -z "$(_plugin_path zsh-syntax-highlighting)" ]]; then
    zplug 'zsh-users/zsh-syntax-highlighting'
  fi
  if [[ -z "$(_plugin_path zsh-syntax-highlighting)" ]]; then
    zplug 'zsh-users/zsh-history-substring-search'
  fi

  if [[ $zplugs ]]; then
    zplug load
  fi
fi

###
# plugin setting
###
_enable_powerlevel10k () {
  plugin_path=$(_powerlevel10k_path)
  if [[ -n "$plugin_path" ]]; then
    source "$plugin_path/powerlevel10k.zsh-theme"
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    return $?
  elif [[ -n "$(command -v zplug)" ]] && zplug check 'romkatv/powerlevel10k'; then
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    return $?
  fi
  return 1
}
_enable_completions () {
  plugin_path=$(_plugin_path zsh-completions)
  if [[ -n "$plugin_path" ]]; then
    fpath=("$plugin_path" $fpath)
    return 0
  fi
  [[ -n "$(command -v zplug)" ]] && zplug check 'zsh-users/zsh-completions'
}
_enable_plugin () {
  name=$1
  plugin_path=$(_plugin_path "$name")
  if [[ -n "$plugin_path" && -f "$plugin_path/$name.zsh" ]]; then
    source "$plugin_path/$name.zsh"
    return $?
  fi
  [[ -n "$(command -v zplug)" ]] && zplug check "zsh-users/$name"
}

if ! _enable_powerlevel10k; then
  autoload -U colors; colors
  PROMPT="%{$fg[cyan]%}%n@%m%{$reset_color%}%(!.#.$) "
  RPROMPT="%{$fg[magenta]%}[ %~ ]%{$reset_color%}"
fi

if _enable_completions; then
  zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
  autoload -Uz compinit; compinit
fi

_enable_plugin zsh-syntax-highlighting
if _enable_plugin zsh-history-substring-search; then
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
fi

unset -f _powerlevel10k_path _plugin_path
unset -f _enable_powerlevel10k _enable_completions _enable_plugin

###
# anyenv
###
if [[ -n "$(command -v anyenv)" ]]; then
  eval "$(anyenv init -)"
fi
if [[ -n "$(command -v pyenv)" && -d "$(pyenv root)/plugins/pyenv-virtualenv" ]]; then
  eval "$(pyenv virtualenv-init -)"
fi

# Google Cloud SDK
if [[ -n "$HOMEBREW_PREFIX" && -d "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk" ]]; then
  source "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
  source "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
fi

###
# 共通コマンド
###
if [[ -n "$(command -v nvim)" ]]; then
  export EDITOR=nvim
elif [[ -n "$(command -v vim)" ]]; then
  export EDITOR=vim
fi

###
# コマンドのエイリアス
###
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
if [ "$(uname)" = "Darwin" ]; then
  alias ls='ls -G'
else
  alias ls='ls --color'
fi
alias ll='ls -l'
alias l.='ls -d.*'
alias rm='rm -i'
alias mv='mv -i'
if [[ "$EDITOR" == "nvim" ]]; then
  alias vim='nvim'
fi

###
# 便利関数
###
function update() {
  brew upgrade
  brew bundle dump -f
  anyenv update
  nvim --headless -c "call dein#update()" -c 'q'
}
