
alias grep='grep --color=auto'
alias ls='ls --group-directories-first --color=auto -p'
alias py='python3'
alias q='exit'
alias v='nvim'

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/';
}

ctrl_k_tmux() {
    if command -v tmux &>/dev/null && [[ -n "$TMUX" ]]; then
        tmux send-keys -t "$TMUX_PANE" C-k
    elif tmux has-session &>/dev/null; then
        tmux attach-session
    else
        tmux
    fi
}

export PS1="\[\e[1m\e[31m\]\h::\u \[\e[33m\]\W\$(parse_git_branch)\[\e[m\] λ "

bind -x '"\C-k": ctrl_k_tmux'
stty -ixon

[[ $- != *i* ]] && return
