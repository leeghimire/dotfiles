#!/bin/zsh

bindkey -e

autoload -Uz compinit && compinit
autoload -Uz vcs_info && precmd() { vcs_info }

setopt appendhistory
setopt extendedglob
setopt incappendhistory
setopt prompt_subst
setopt sharehistory

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':vcs_info:git:*' formats ' [%b]'

PROMPT='%B%F{red}%m::%n %F{yellow}%1~%b%f λ '
RPROMPT='%F{yellow}${vcs_info_msg_0_}%f'

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

set -o nomatch
