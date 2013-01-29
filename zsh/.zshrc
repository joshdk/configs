# ~/.zshrc
#
# Main config file for ZSH




# {{{ ZSH settings
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob
setopt PROMPT_SUBST
setopt HIST_IGNORE_SPACE
unsetopt beep
unsetopt PROMPT_CR
autoload -Uz compinit
autoload -U colors && colors
zstyle :compinstall filename '/home/josh/.zshrc'
compinit
bindkey -e
bindkey "^[[3~" delete-char
bindkey "^H"    backward-delete-word
bindkey "^[[7~" beginning-of-line
bindkey "^[Oc"  forward-word
bindkey "^[Od"  backward-word
bindkey "^[[A"  history-search-backward
bindkey "^[[B"  history-search-forward
# }}}


# {{{ Load plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# }}}


# {{{ Build environment
# Set TERM, if we're not in a vty
if [ "$TERM" != "linux" ]; then
	export TERM="screen-256color"
fi

export EDITOR='vim'
export SHELL='/bin/zsh'
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$HOME/.bin"
 # }}}


# {{{ Program aliases
# zsh aliases
alias zr="source $HOME/.zshrc"

# things to ignore
alias rm=' rm'

# vim aliases
alias vi='vim'
alias vio='vim -O'
alias vir='vim -R'

# ls aliases
alias ls=' ls -p --group-directories-first --color=auto'
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


# {{{ Filetype aliases
alias -s pdf=zathura
alias -s tex=vim
alias -s torrent=transmission

alias -s c=vim
alias -s h=vim
alias -s cc=vim
alias -s hh=vim
alias -s cpp=vim
alias -s hpp=vim

alias -s png=feh
alias -s gif=feh
alias -s jpg=feh
alias -s jpeg=feh
alias -s bmp=feh
alias -s svg=feh
# }}}


# {{{ Misc functions
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
# }}}


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
			echo -n "(%F{green}git%f:%F{green}$branch $symbol%f)"
		fi
	fi
}
# }}}


# {{{ Configure prompt
if [[ "$(id -u)" -eq 0 ]]; then
	PROMPT=$(echo -ne "\n[%F{red}%n%f@%F{red}%M%f]-(%F{blue}%.%f) # ")
else
	PROMPT=$(echo -ne "\n(%F{blue}%n%f@%F{blue}%M%f)-(%F{blue}%.%f) $ ")
fi

RPROMPT='$(info-git)%f'
# }}}


TODO
