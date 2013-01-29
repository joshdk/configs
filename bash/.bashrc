# ~/.bashrc
#
# Main config file for Bash




#{{{ Bash settings
# Source global definitions
	if [ -f /etc/bashrc ]; then
		. /etc/bashrc
	fi
#}}}


# {{{ Build environment
# Set TERM, if we're not in a vty
if [ "$TERM" != "linux" ]; then
	export TERM="screen-256color"
fi

export EDITOR='vim'
export SHELL='/bin/bash'
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$HOME/.bin"

PROMPT_COMMAND=precmd

#{{{ Colors
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset
#}}}
 # }}}


# {{{ Program aliases
# zsh aliases
alias br="source $HOME/.bashrc"

# vim aliases
alias vi='vim'
alias vio='vim -O'
alias vir='vim -R'

# ls aliases
alias ls='ls -p --group-directories-first --color=auto'
alias la='ls -A'
alias ll='ls -lh'
alias lla='ls -lhA'

# cd aliases
function cdl(){
	if [ -n "$1" ]
	then
		cd "$1"
	else
		cd
	fi
	ls
}
alias cdd='cdl ~/Desktop/'

#screen aliases
alias s='screen'
alias sls='screen -ls'
alias sdr='screen -dr'

#git aliases
alias g='git'
alias gi='git init'
alias gs='git status'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit'
alias gb='git branch'
alias gk='git checkout'
alias gkm='git checkout master'
alias gkd='git checkout develop'
alias gkb='git checkout -b'
alias gp='git push'
alias gpo='git push origin'
alias gpom='git push origin master'
alias gm='git merge'
alias gmm='git merge --no-ff'
alias gd='git diff'
alias gg='git log --graph --oneline --all'

# rsync aliases
alias pcp='rsync -arhP'
alias pmv='rsync -arhP --remove-source-files'

# misc aliases
alias less='less -r'
alias grep='grep --color=auto'
alias tree='tree -ACFr'
alias grind='valgrind --tool=memcheck --leak-check=full --show-reachable=yes --read-var-info=yes'
alias browse='nautilus --no-desktop "$PWD" &>/dev/null &!'
alias socks='ssh -fND'
alias ping-scan='nmap -sP -PE -R'
alias port-scan='nmap -p'
# }}}


#{{{ Misc functions
# Custom manpage colors
function man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[47;30m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
	man "$@"
}

#display the permissions, user, & group for every directory up to the root
function pr(){
	local dir="$PWD"
	if [ -n "$1" ]
	then
		dir="$1"
	fi
	if [ "$dir" == '.' ]
	then
		stat -c '%A %U %G %n' "$dir"
	elif [ "$dir" == '/' ]
	then
		stat -c '%A %U %G %n' "$dir"
	else
		stat -c '%A %U %G %n' "$dir"
		pr $(dirname "$dir")
	fi
}
#}}}


# {{{ Build git prompt status
function info-git(){
	branch=$(git symbolic-ref HEAD 2>/dev/null | sed "s/refs\/heads\///g")
	if [[ -n "$branch" ]]; then
		changes=$(git status --porcelain 2>/dev/null | grep '^?? ')
		commits=$(git status --porcelain 2>/dev/null | grep -v '^?? ')
		symbol=""
		if [[ -n "$commits" ]]; then
			symbol+="!"
		else
			symbol+="."
		fi
		if [[ -n "$changes" ]]; then
			symbol+="?"
		else
			symbol+="."
		fi
		if [[ -n "$symbol" ]]; then
			echo -n "(${txtgrn}git${txtrst}:${txtgrn}$branch $symbol${txtrst})"
		fi
	fi
}
# }}}


#{{{ Configure prompt
function precmd(){
	GIT=$(info-git)
	if [[ -n "$GIT" ]]; then
		GIT="-$GIT"
	fi

	if [[ "$(id -u)" -eq 0 ]]; then
		PS1=$(echo -ne "\n(${txtred}\u${txtrst}@${txtred}\h${txtrst})-(${txtblu}\W${txtrst})$GIT\n# ")
	else
		PS1=$(echo -ne "\n(${txtblu}\u${txtrst}@${txtblu}\h${txtrst})-(${txtblu}\W${txtrst})$GIT\n$ ")
	fi
}
#}}}


TODO
