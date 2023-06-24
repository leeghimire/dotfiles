parse_git_branch() { git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'; }
export PS1="\[\e[1m\e[31m\]\h::\u \[\e[33m\]\W\$(parse_git_branch)\[\e[m\] λ "

alias grep='grep --color=auto'
alias ls='ls --group-directories-first --color=auto -p'
alias q='exit'
alias v='nvim'

[[ $- != *i* ]] && return
