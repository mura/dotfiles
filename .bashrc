#==========================================================#
# .bashrc for develop server
#==========================================================#

# Source global definitions
if [ -f /etc/bash.bashrc ]; then
	. /etc/bash.bashrc
fi

#==========================================================#
# 環境変数
#==========================================================#
UNAME=`uname`

#export LANG=ja_JP.eucJP
#export LC_CTYPE=${LANG}
#export LC_MESSAGES=${LANG}
export PATH="${HOME}/bin:/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin"
export CVSROOT=/home/cvsroot
#export CVS_RSH=ssh
export EDITOR=vim
export CVSEDITOR=${EDITOR}
#export PAGER=jless
#export PAGER=lv
#export JLESSCHARSET=japanese-euc

# 端末がxtermならカラーにする
if [ ${TERM} = "xterm-256color" ] ; then
	export TERM=xterm-color
fi

#==========================================================#
# プロンプト
#==========================================================#
# Red Hat
#PS1='[\u@\h \W]\$ '
# cygwin hack
#PS1=$'\\[\\033[35m[ \\w ]\n\\033[36m\\u@\\h\\033[0m\\$ '
PS1=$'\e[35m[ \w ]\n\e[36m\u@\h\e[0m\$ '

#==========================================================#
# コマンドのエイリアス
#==========================================================#
alias rm='rm -i'
alias mv='mv -i'
if [ ${UNAME} = "Linux" ]
then
	export LS_OPTIONS='--color=auto'
	eval "`dircolors`"
	alias ls='ls $LS_OPTIONS'
	alias jless='less -sir'
	alias top='top -d 1 -S'
else
	alias ls='ls -GF'
fi	
alias ll='ls -l'
alias la='ls -la'
alias lt='ls -ltr'
# jls
#alias jls='jls -GF'
#alias jll='jls -l'
#alias jla='jls -la'
#alias jlt='jls -ltr'
# apache log
alias taila='tail -f /var/log/httpd/access_log'
alias taile='tail -f /var/log/httpd/error_log'
alias rpmbuild_priv='rpmbuild -D "_private /private"'
alias grep='grep --color'
alias egrep='egrep --color'

#==========================================================#
# SSH Agent for WSL
#==========================================================#
if [[ -n "$(command -v npiperelay.exe)" ]]; then
	# Code extracted from https://stuartleeks.com/posts/wsl-ssh-key-forward-to-windows/ with minor modifications

	# Configure ssh forwarding
	export SSH_AUTH_SOCK=$HOME/.1password/agent.sock
	# need `ps -ww` to get non-truncated command for matching
	# use square brackets to generate a regex match for the process we want but that doesn't match the grep command running it!
	ALREADY_RUNNING=$(ps -auxww | grep -q "[n]piperelay.exe -ei -s //./pipe/openssh-ssh-agent"; echo $?)
	if [[ $ALREADY_RUNNING != "0" ]]; then
		if [[ -S $SSH_AUTH_SOCK ]]; then
			# not expecting the socket to exist as the forwarding command isn't running (http://www.tldp.org/LDP/abs/html/fto.html)
			echo "removing previous socket..."
			rm $SSH_AUTH_SOCK
		fi
		echo "Starting SSH-Agent relay..."
		# setsid to force new session to keep running
		# set socat to listen on $SSH_AUTH_SOCK and forward to npiperelay which then forwards to openssh-ssh-agent on windows
		(setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork &) >/dev/null 2>&1
	fi
fi

#==========================================================#
# 独自関数
#==========================================================#
function wp() {
	if [ -z "$1" ] ; then
		echo "Usage: wp [process]"
	else	
		P=`ps axw | grep $1 | grep -v grep | wc -l`
		P=${P-0}
		echo "$1 ${P}"
	fi	
}	

#if [ -f /usr/local/etc/bash_completion ]; then
#	. /usr/local/etc/bash_completion
#fi
