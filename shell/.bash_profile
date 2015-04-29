#!/usr/bin/env bash

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

PATH=$PATH:$HOME/bin
export PATH

export LESS="-I $LESS"

which gvim >/dev/null 2>&1 && export EDITOR=gvim\ -f
