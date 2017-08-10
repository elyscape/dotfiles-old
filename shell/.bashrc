#!/usr/bin/env bash

if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

if [ -f ~/.bashrc.local ]; then
  . ~/.bashrc.local
fi

shopt -s no_empty_cmd_completion histappend
set -o ignoreeof

# Allow forward history search with ^S
[[ $- == *i* ]] && stty -ixon

if [ "$( uname -s )" = 'Darwin' ]; then
  if [ -f "$( brew --prefix )/share/bash-completion/bash_completion" ]; then
    . "$( brew --prefix )/share/bash-completion/bash_completion"
  fi

  if [ -f "$( brew --prefix nvm )/nvm.sh" ]; then
    export NVM_DIR=~/.nvm
    source "$( brew --prefix nvm )/nvm.sh"
    which npm >/dev/null 2>&1 && source <(npm completion)
  fi
fi

[ -f ~/.aliases ] && . ~/.aliases
