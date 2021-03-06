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
# zplug
###
if [ -d "/usr/local/opt/zplug" ]; then
  # Homebrew
  export ZPLUG_HOME=/usr/local/opt/zplug
  source $ZPLUG_HOME/init.zsh
elif [ -d "/usr/share/zplug" ]; then
  # Ubuntu
  export ZPLUG_HOME=~/.zplug
  source /usr/share/zplug/init.zsh
elif [ -d "/usr/share/zsh/scripts/zplug" ]; then
  # Arch
  export ZPLUG_HOME=~/.zplug
  source /usr/share/zsh/scripts/zplug/init.zsh
elif [ -f ~/.zplug/init.zsh ]; then
  # Manual
  export ZPLUG_HOME=~/.zplug
  source $ZPLUG_HOME/init.zsh
fi

###
# Set shell prompt
###
if [ -f "/usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme" ]; then
  source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
elif type "zplug" >/dev/null 2>&1; then
  zplug 'romkatv/powerlevel10k', as:theme, depth:1
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
else
  autoload -U colors; colors
  PROMPT="%{$fg[cyan]%}%n@%m%{$reset_color%}%(!.#.$) "
  RPROMPT="%{$fg[magenta]%}[ %~ ]%{$reset_color%}"
fi

# anyenv
eval "$(anyenv init -)"

# zsh-completions
if [ -d "/usr/local/share/zsh-completions" ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
  zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
  autoload -Uz compinit
  compinit
else
  zplug 'zsh-users/zsh-completions'
fi

# zsh-syntax-highlighting
if [ -f "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [ -f "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
  zplug 'zsh-users/zsh-syntax-highlighting'
fi

# zsh-history-substring-search
if [ -f "/usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh" ]; then
  source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
else
  zplug 'zsh-users/zsh-history-substring-search'
fi

# Google Cloud SDK
if [ -d "/usr/local/Caskroom/google-cloud-sdk" ]; then
  source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
  source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
fi

# zplug load
if [ $zplugs ]; then
  zplug load
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
alias vim='nvim'

###
# 便利関数
###
function update() {
  brew upgrade
  anyenv update
  nvim --headless -c "call dein#update()" -c 'q'
}
