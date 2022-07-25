#!/usr/bin/env bash
# shellcheck disable=SC1090

if [[ -f "${HOME}/.bashrc" ]]; then
	. "${HOME}/.bashrc"
fi

if [[ -f "${HOME}/.bash_profile.local" ]]; then
	. "${HOME}/.bash_profile.local"
fi

if hash gvimf &>/dev/null; then
	EDITOR='gvimf'
elif hash gvim &>/dev/null; then
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
	PATH="${GOPATH}/bin:${PATH}"
fi

if [[ -x /usr/bin/dircolors ]]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# bash-preexec goes here
# preexec() { printf '\033]0;%s@%s:%s — %s\007' "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}" "${1}" ; }
# precmd() { printf '\033]0;%s@%s:%s — %s\007' "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}" "${0}" ; }

if [[ -f "${HOME}/.iterm2_shell_integration.bash" ]]; then
	. "${HOME}/.iterm2_shell_integration.bash"
fi
