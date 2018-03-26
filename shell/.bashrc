#!/usr/bin/env bash
# shellcheck disable=SC1090

if [[ -f /etc/bashrc ]]; then
	. /etc/bashrc
fi
if [[ -f "${HOME}/.bashrc.local" ]]; then
	. "${HOME}/.bashrc.local"
fi


shopt -s no_empty_cmd_completion histappend
set -o ignoreeof

# Allow forward history search with ^S
[[ "$-" == *i* ]] && stty -ixon

if [[ "$(uname -s)" == 'Darwin' ]]; then
	brew_prefix="$(brew --prefix)"
	if [[ -f "${brew_prefix}/share/bash-completion/bash_completion" ]]; then
		. "${brew_prefix}/share/bash-completion/bash_completion"
	fi

	if [[ -f "${brew_prefix}/opt/nvm/nvm.sh" ]]; then
		export NVM_DIR="${HOME}/.nvm"
		source "${brew_prefix}/opt/nvm/nvm.sh"
		hash npm &>/dev/null && source <(npm completion)
	fi
	unset brew_prefix
fi

if [[ -f "${HOME}/.aliases" ]]; then
	. "${HOME}/.aliases"
fi
