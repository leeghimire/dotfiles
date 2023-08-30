#!/bin/zsh

bindkey -e

autoload -Uz colors && colors
autoload -Uz compinit && compinit
autoload -Uz vcs_info && precmd() { vcs_info }

setopt appendhistory
setopt extendedglob
setopt incappendhistory
setopt prompt_subst
setopt sharehistory

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':vcs_info:git:*' formats ' [%b]'

alias battery='cat /sys/class/power_supply/BAT0/capacity'
alias ls='exa'
alias v='nvim'

PROMPT='%B%F{red}%m::%n %F{yellow}%1~%b%f λ '
RPROMPT='%F{yellow}${vcs_info_msg_0_}%f'

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then 
  exec startx &>/dev/null 
fi
