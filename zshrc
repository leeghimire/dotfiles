#!/bin/zsh

autoload -Uz colors && colors
autoload -Uz compinit && compinit
autoload -Uz vcs_info && precmd() { vcs_info }

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats ' [%b]'

zmodload zsh/complist

bindkey -v
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

PROMPT='%B%F{red}%m::%n %F{yellow}%1~%b%f λ '
RPROMPT='%F{yellow}${vcs_info_msg_0_}%f'

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

setopt appendhistory
setopt extendedglob
setopt incappendhistory
setopt prompt_subst
setopt sharehistory

alias grep='grep --color=auto'
alias ls='ls --group-directories-first --color=auto -p'
alias v='nvim'
