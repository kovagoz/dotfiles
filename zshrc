HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

umask 0002;

setopt autocd extendedglob
bindkey -v

autoload -Uz compinit
compinit

autoload -Uz vcs_info
autoload -U colors && colors

zstyle ':vcs_info:git*' unstagedstr "?"
zstyle ':vcs_info:git*' stagedstr "!"
zstyle ':vcs_info:git*' check-for-changes false
zstyle ':vcs_info:git*' formats " %{$fg[yellow]%}(%b%c%u)%{$reset_color%}"
precmd() {
    vcs_info
}

VIMODE="[i]"

function zle-keymap-select {
    VIMODE="${${KEYMAP/vicmd/[n]}/(main|viins)/[i]}"
    zle reset-prompt
}

zle -N zle-keymap-select

setopt prompt_subst

PS1='%{%f%}%{%F{white}%}%~${vcs_info_msg_0_} ${VIMODE} $%{%f%} '

eval `dircolors ~/.dotfiles/dircolors/dircolors.256dark`

alias ls='ls --color=always'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias pw='vim ~/.pwdb'
alias dev="ln -sf $SSH_AUTH_SOCK ~/.ssh/auth_sock; tmux attach"

export PYTHONPATH=~/lib/python2.7/site-packages

path+=(~/bin)
