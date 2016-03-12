source ~/.git-prompt.sh
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export PS1="\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;226m\]\w\[$(tput sgr0)\]\[\033[38;5;160m\]\$(__git_ps1)\[\033[38;5;15m\]> \[$(tput sgr0)\]"


if [[ $- == *i* ]]
then
	bind '"\e[A": history-search-backward'
	bind '"\e[B": history-search-forward'
fi

alias gs="git status"
alias gd="git diff"

alias ll="ls -la"
