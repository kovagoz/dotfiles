HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd)"

setopt autocd extendedglob
bindkey -v

autoload -Uz compinit
compinit

autoload -Uz vcs_info
autoload -U colors && colors

zstyle ':vcs_info:git*' formats " %{$fg[grey]%}(%b)%{$reset_color%}"
precmd() {
    vcs_info
}

setopt prompt_subst

PS1='%{%f%}%{%F{white}%}%~${vcs_info_msg_0_} $%{%f%} '

eval `dircolors $DIR/dircolors-solarized/dircolors.256dark`

alias ls='ls --color=always'
alias ll='ls -l'
alias la='ls -a'
