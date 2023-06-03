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
if [[ -x "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export HOMEBREW_BUNDLE_FILE=~/.config/brewfile/Brewfile
elif [[ -x "/usr/local/bin/brew" ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
  export HOMEBREW_BUNDLE_FILE=~/.config/brewfile/Brewfile
elif [[ -x /bin/bash && -d "/home/linuxbrew/.linuxbrew" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  export HOMEBREW_BUNDLE_FILE=~/.config/brewfile/Brewfile.linux
fi

###
# fpath
###
if [[ -n "$HOMEBREW_PREFIX" && -d "$HOMEBREW_PREFIX/share/zsh/site-functions" ]]; then
  fpath=("$HOMEBREW_PREFIX/share/zsh/site-functions" $fpath)
fi

fpath=(~/.local/share/zsh/functions $fpath)

###
# PATH
###
export PATH="$HOME/.local/bin:$PATH"
if [[ -d "$HOME/.anyenv/bin" ]]; then
  export PATH="$HOME/.anyenv/bin:$PATH"
fi
if [[ -d "$HOME/.deno/bin" ]]; then
  export PATH="$HOME/.deno/bin:$PATH"
fi
if [[ -d "/mnt/c/Users/mura/AppData/Local/Programs/Microsoft VS Code/bin" ]]; then
  export PATH="/mnt/c/Users/mura/AppData/Local/Programs/Microsoft VS Code/bin:$PATH"
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
autoload -Uz powerlevel10k-path plugin-path
if [[ -n "$(command -v zplug)" ]]; then
  if [[ -z "$(powerlevel10k-path)" ]]; then
    zplug 'romkatv/powerlevel10k', as:theme, depth:1
  fi
  if [[ -z "$(plugin-path zsh-completions)" ]]; then
    zplug 'zsh-users/zsh-completions'
  fi
  if [[ -z "$(plugin-path zsh-syntax-highlighting)" ]]; then
    zplug 'zsh-users/zsh-syntax-highlighting'
  fi
  if [[ -z "$(plugin-path zsh-syntax-highlighting)" ]]; then
    zplug 'zsh-users/zsh-history-substring-search'
  fi

  if [[ $zplugs ]]; then
    zplug load
  fi
fi

###
# plugin setting
###
autoload -Uz enable-powerlevel10k
if ! enable-powerlevel10k; then
  autoload -U colors; colors
  PROMPT="%{$fg[cyan]%}%n@%m%{$reset_color%}%(!.#.$) "
  RPROMPT="%{$fg[magenta]%}[ %~ ]%{$reset_color%}"
fi
unset -f enable-powerlevel10k

autoload -Uz enable-completions
if enable-completions; then
  zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
  if [[ -n "$ASDF_DIR" ]]; then
    fpath=(${ASDF_DIR}/completions $fpath)
  fi
  autoload -Uz compinit; compinit
fi
unset -f enable-completions

autoload -Uz enable-plugin
enable-plugin zsh-syntax-highlighting
if enable-plugin zsh-history-substring-search; then
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey "${terminfo[kcuu1]}" history-substring-search-up
  bindkey "${terminfo[kcud1]}" history-substring-search-down
fi
unset -f enable-plugin

###
# anyenv
###
if [[ -n "$(command -v anyenv)" ]]; then
  eval "$(anyenv init -)"
fi
if [[ -n "$(command -v pyenv)" && -d "$(pyenv root)/plugins/pyenv-virtualenv" ]]; then
  eval "$(pyenv virtualenv-init -)"
fi

###
# asdf
###
if [[ -n "$HOMEBREW_PREFIX" && -f "$HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh" ]]; then
  . "$HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh"
elif [[ -f "$HOME/.asdf/asdf.sh" ]]; then
  . "$HOME/.asdf/asdf.sh"
fi

# Google Cloud SDK
if [[ -n "$HOMEBREW_PREFIX" && -d "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk" ]]; then
  source "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
  source "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
fi

# ssh agent for WSL
if [[ -n "$(command -v npiperelay.exe)" ]]; then
  autoload -U agent-bridge; agent-bridge
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
if [[ "$OSTYPE" =~ "^darwin" ]]; then
  alias ls='ls -GF'
else
  alias ls='ls -F --color=auto'
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
update () {
  if [[ -n "$(command -v brew)" ]]; then
    brew upgrade
    brew bundle dump -f
  fi
  if [[ -n "$(command -v anyenv)" ]]; then
    anyenv update
  fi
  if [[ -n "$(command -v nvim)" ]]; then
    nvim --headless -c "call dein#update()" -c 'q'
  fi
}
