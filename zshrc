#!/bin/zsh

bindkey -v

autoload -Uz compinit
autoload -Uz vcs_info

compinit
precmd() { vcs_info }

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats ' (%b)'

PROMPT='%B%F{red}%m::%n %F{yellow}%1~${vcs_info_msg_0_}%b%f λ '
RPROMPT=

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

setopt appendhistory
setopt correct
setopt extendedglob
setopt incappendhistory
setopt prompt_subst
setopt sharehistory

alias grep='grep --color=auto'
alias ls='ls --group-directories-first --color=auto -p'
alias py='python3'
alias v='nvim'
