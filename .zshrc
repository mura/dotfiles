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

#######################################
# 環境変数
#######################################
typeset -U path fpath
fpath=(~/.local/share/zsh/functions $fpath)

# Homebrew
autoload -Uz init_homebrew; init_homebrew

# path
autoload -Uz init_path; init_path

# ssh agent (1Password / WSL / Linux)
autoload -Uz init_ssh_agent; init_ssh_agent

# EDITOR
if [[ -n "$(command -v nvim)" ]]; then
  export EDITOR=nvim
elif [[ -n "$(command -v vim)" ]]; then
  export EDITOR=vim
fi

#######################################
# プラグイン
#######################################

# zplugの初期化（存在する場合）
autoload -Uz init_zplug; init_zplug

# プラグインのロード
# Homebrew > システムパッケージ > zplug の優先順位で検索・ロード
autoload -Uz load-plugin
typeset -g needs_zplug_install=0

# 必要なプラグインをロード
load-plugin zsh-completions
load-plugin zsh-syntax-highlighting
load-plugin zsh-history-substring-search

# zplugで新規インストールが必要な場合
if [[ -n "$(command -v zplug)" ]]; then
  if [[ $needs_zplug_install -eq 1 ]]; then
    zplug install
  fi
  zplug load
fi
unset needs_zplug_install

# 補完の設定
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
autoload -Uz compinit; compinit

# zsh-history-substring-searchのキーバインド
if (( $+functions[history-substring-search-up] )); then
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey "${terminfo[kcuu1]}" history-substring-search-up
  bindkey "${terminfo[kcud1]}" history-substring-search-down
fi

#######################################
# Shell integrations
#######################################

# mise
if [[ -n "$(command -v mise)" ]]; then
  eval "$(mise activate zsh)"
fi

# fzf
if [[ -n "$(command -v fzf)" ]]; then
  eval "$(fzf --zsh)"
  export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
fi

# uv
if [[ -n "$(command -v uv)" ]]; then
  eval "$(uv generate-shell-completion zsh)"
fi

# Google Cloud SDK
if [[ -n "$HOMEBREW_PREFIX" && -d "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk" ]]; then
  source "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
  source "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
fi

#######################################
# エイリアス
#######################################
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

#######################################
# 便利関数
#######################################
update () {
  if [[ -n "$(command -v brew)" ]]; then
    brew upgrade
    brew bundle dump -f
  fi
  if [[ -n "$(command -v nvim)" ]]; then
    nvim --headless -c "call dein#update()" -c 'q'
  fi
}

#######################################
# プロンプト
#######################################
if [[ -n "$(command -v starship)" ]]; then
  eval "$(starship init zsh)"
else
  autoload -U colors; colors
  PROMPT="%{$fg[cyan]%}%n@%m%{$reset_color%}%(!.#.$) "
  RPROMPT="%{$fg[magenta]%}[ %~ ]%{$reset_color%}"
fi
