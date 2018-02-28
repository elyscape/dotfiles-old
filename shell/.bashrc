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
  brew_prefix="$( brew --prefix )"
  if [ -f "${brew_prefix}/share/bash-completion/bash_completion" ]; then
    . "${brew_prefix}/share/bash-completion/bash_completion"
  fi

  if [ -f "${brew_prefix}/opt/nvm/nvm.sh" ]; then
    export NVM_DIR=~/.nvm
    source "${brew_prefix}/opt/nvm/nvm.sh"
    which npm >/dev/null 2>&1 && source <(npm completion)
  fi
  unset brew_prefix
fi

[ -f ~/.aliases ] && . ~/.aliases
