# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/mura/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

###
# Set shell options
###
# 広瀬雄二さんのお薦めオプション
# http://www.gentei.org/~yuuji/rec/pc/intro-zsh.html
# setopt auto_menu auto_cd correct auto_name_dirs auto_remove_slash
# setopt extended_history hist_ignore_dups hist_ignore_space prompt_subst
# setopt pushd_ignore_dups rm_star_silent sun_keyboard_hack
# setopt extended_glob list_types no_beep always_last_prompt
# setopt cdable_vars sh_word_split auto_param_keys

# 以下、広瀬レコメンドは小文字、そうでないのは大文字にしてある
setopt auto_cd 			# コマンドが省略されていたら cd とみなす
setopt AUTO_PUSHD		# cd 時にOldDir を自動的にスタックに積む
setopt correct			# コマンドのスペルチェック
setopt auto_name_dirs		# よく判らん
setopt auto_remove_slash	# 補完が/で終って、つぎが、語分割子か/かコマンド
				# の後(; とか & )だったら、補完末尾の/を取る
setopt extended_history 	# ヒストリに時刻情報もつける
setopt extended_glob		# グロブで、特殊文字"#,~,^"を使う、
setopt FUNCTION_ARGZERO 	#  $0 にスクリプト名/シェル関数名を格納

setopt hist_ignore_dups		# 前のコマンドと同じならヒストリに入れない
setopt hist_ignore_space	# 空白ではじまるコマンドをヒストリに保持しない
setopt HIST_IGNORE_ALL_DUPS	# 重複するヒストリを持たない
setopt HIST_NO_FUNCTIONS	# 関数定義をヒストリに入れない
setopt HIST_NO_STORE		# history コマンドをヒストリに入れない
setopt HIST_REDUCE_BLANKS	# 履歴から冗長な空白を除く
setopt MULTIOS			# 名前付きパイプ的に入出力を複数開ける
setopt NUMERIC_GLOB_SORT	# グロブの数のマッチを辞書式順じゃなくって数値の順
setopt prompt_subst		# プロンプト文字列で各種展開を行なう
setopt no_promptcr              # 改行コードで終らない出力もちゃんと出力する
setopt pushd_ignore_dups	# ディレクトリスタックに、同じディレクトリを入れない
#setopt rm_star_silent		# rm * とかするときにクエリしない
#setopt no_beep			# ZLE のエラーでビープしない
#setopt cdable_vars		# cd の引数のdir がないとき ~をつけてみる
setopt SHARE_HISTORY		# 複数プロセスで履歴を共有
setopt SHORT_LOOPS		# loop の短縮形を許す
setopt sh_word_split		# よく判らん
setopt RC_EXPAND_PARAM		# {}をbash ライクに展開
setopt TRANSIENT_RPROMPT 	# 右プロンプトに入力がきたら消す

# Ctrl-D でログアウトするのを抑制する。
#setopt  ignore_eof

# グロブがマッチしないときエラーにしない
# http://d.hatena.ne.jp/amt/20060806/ZshNoGlob
setopt null_glob

# プロセスをシェルから切り離せるようにする
setopt nohup

# デバッグ用 コマンドラインがどのように展開されたか表示
#setopt xtrace

# 小文字に対して大文字も補完する
# http://www.ex-machina.jp/zsh/index.cgi?FAQ%40zsh%A5%B9%A5%EC#l1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

###
# Set shell prompt
###
autoload -U colors; colors
PROMPT="%{$fg[cyan]%}%n@%m%{$reset_color%}%(!.#.$) "
RPROMPT="%{$fg[magenta]%}[ %~ ]%{$reset_color%}"

#==========================================================#
# コマンドのエイリアス
#==========================================================#
#---- Fedoraから移植 --------------------------------------#
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
#---- /Fedoraから移植 -------------------------------------#
alias rm='rm -i'
alias mv='mv -i'
# apache log
alias taila='tail -f /var/log/httpd/access_log'
alias taile='tail -f /var/log/httpd/error_log'
alias rpmbuild_priv='rpmbuild -D "_private /private"'
alias top='top -d 1'

#==========================================================#
# 独自関数
#==========================================================#
function mssh() {
  if [[ "$TERM" == "screen" || "$TERM" == "screen-bce" ]];then
    local host=${1%%.*}
    screen -t $host ssh "$1"
  else
    ssh "$@"
  fi
}
