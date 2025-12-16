#!/bin/sh

# config variables for various tools

#export RUBYGEMS_GEMDEPS='-'
export EDITOR=$(which nvim)
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOW_DIRTYSTATE=1

function man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;31m") \
    LESS_TERMCAP_ue=$(printf "\e[01m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}
