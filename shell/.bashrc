#!/usr/bin/env bash

if [ -f ~/.bashrc.local ]; then
  . ~/.bashrc.local
fi

shopt -s no_empty_cmd_completion
set -o ignoreeof

if [ "$( uname -s )" = 'Darwin' ]; then
  if [ -f "$( brew --prefix )/share/bash-completion/bash_completion" ]; then
    . "$( brew --prefix )/share/bash-completion/bash_completion"
  fi

  export HOMEBREW_CASK_OPTS="--appdir=/Applications"
elif [ "$OS" = 'Windows_NT' ]; then
  # From https://help.github.com/articles/working-with-ssh-key-passphrases/
  # Note: ~/.ssh/environment should not be used, as it
  #       already has a different purpose in SSH.

  env=~/.ssh/agent.env

  # Note: Don't bother checking SSH_AGENT_PID. It's not used
  #       by SSH itself, and it might even be incorrect
  #       (for example, when using agent-forwarding over SSH).

  agent_is_running() {
    if [ "$SSH_AUTH_SOCK" ]; then
      # ssh-add returns:
      #   0 = agent running, has keys
      #   1 = agent running, no keys
      #   2 = agent not running
      ssh-add -l >/dev/null 2>&1 || [ $? -eq 1 ]
    else
      false
    fi
  }

  agent_has_keys() {
    ssh-add -l >/dev/null 2>&1
  }

  agent_load_env() {
    . "$env" >/dev/null
  }

  agent_start() {
    (umask 077; ssh-agent >"$env")
    . "$env" >/dev/null
  }

  if ! agent_is_running; then
    agent_load_env
  fi

  # if your keys are not stored in ~/.ssh/id_rsa or ~/.ssh/id_dsa,
  # you'll need to paste the proper path after ssh-add
  if ! agent_is_running; then
    agent_start
    ssh-add
  elif ! agent_has_keys; then
    ssh-add
  fi

  unset env
fi

[ -f ~/.aliases ] && . ~/.aliases