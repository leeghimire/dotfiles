parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export PATH="$PATH:/home/lee/.local/bin"

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export GTK_THEME='Arc-Dark'
export PS1="\[\e[35m\]\u\[\e[00m\]@\h \[\e[32m\]\w \[\e[91m\]\$(parse_git_branch)\[\e[00m\]$ "

export HISTFILESIZE=2500
export HISTSIZE=2500

alias v='__nvim_wrapper'
__nvim_wrapper() {
  if [ -z "$1" ]; then
    nvim "$(fzf --height 40% --reverse)"
  else
    command nvim "$@"
  fi
}

alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias l='ls -al'
alias q='exit'
alias open='xdg-open'


[[ $- != *i* ]] && return
