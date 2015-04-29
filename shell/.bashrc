#!/usr/bin/env bash

if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

if [ -f ~/.bashrc.local ]; then
  . ~/.bashrc.local
fi

shopt -s no_empty_cmd_completion
set -o ignoreeof

[ -f /etc/inputrc ] && bind -f /etc/inputrc

if [ "$( uname -s )" = 'Darwin' ]; then
  if [ -f "$( brew --prefix )/share/bash-completion/bash_completion" ]; then
    . "$( brew --prefix )/share/bash-completion/bash_completion"
  fi

  export HOMEBREW_CASK_OPTS="--appdir=/Applications"
fi

[ -f ~/.aliases ] && . ~/.aliases
