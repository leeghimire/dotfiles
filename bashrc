parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export GTK_THEME='Arc-Dark'
export PS1="\e[1m\e[31m\h::\u \e[33m\W \$(parse_git_branch)\e[m λ "

export HISTFILESIZE=2500
export HISTSIZE=2500

alias grep='grep --color=auto'
alias v='nvim'
alias ls='ls --color=auto'
alias l='ls -al'
alias q='exit'
alias open='xdg-open'

[[ $- != *i* ]] && return
