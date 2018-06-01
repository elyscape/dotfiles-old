#!/usr/bin/env bash
# shellcheck disable=SC1090

if [[ -f "${HOME}/.bashrc" ]]; then
	. "${HOME}/.bashrc"
fi

if [[ -f "${HOME}/.bash_profile.local" ]]; then
	. "${HOME}/.bash_profile.local"
fi

PATH="$PATH:$HOME/bin"
export PATH

if hash gvim &>/dev/null; then
	EDITOR='gvim -f'
else
	EDITOR='vim'
fi
export EDITOR

if hash rbenv &>/dev/null; then
	eval "$(rbenv init -)"
fi
if hash pyenv &>/dev/null; then
	eval "$(pyenv init -)"
fi
if hash pyenv-virtualenv-init &>/dev/null; then
	eval "$(pyenv virtualenv-init -)"
	export VIRTUAL_ENV_DISABLE_PROMPT='1'
fi

if hash go 2>/dev/null; then
	GOPATH="$(go env GOPATH)"
	export GOPATH
	PATH="${PATH}:$(go env GOPATH)/bin"
fi

if [[ -f "${HOME}/.iterm2_shell_integration.bash" ]]; then
	. "${HOME}/.iterm2_shell_integration.bash"
fi

export HISTCONTROL='ignoreboth'
export HISTTIMEFORMAT='%F %T '

# Support for negative HISTSIZE values was added in Bash 4.3
if [[ "${BASH_VERSINFO[0]}" -ge '5' ]] ||
	([[ "${BASH_VERSINFO[0]}" -eq '4' ]] &&
		[[ "${BASH_VERSINFO[1]}" -gt '2' ]]); then
	export HISTSIZE='-1'
else
	export HISTSIZE='100000'
fi
