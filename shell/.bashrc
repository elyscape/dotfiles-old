#!/usr/bin/env bash
# shellcheck disable=SC1090

if [[ -f /etc/bashrc ]]; then
	. /etc/bashrc
fi
if [[ -f "${HOME}/.bashrc.local" ]]; then
	. "${HOME}/.bashrc.local"
fi

shopt -s \
	checkhash \
	globstar \
	histappend \
	no_empty_cmd_completion

set -o ignoreeof

# Allow forward history search with ^S
[[ "$-" == *i* ]] && stty -ixon

if [[ "$(uname -s)" == 'Darwin' ]]; then
	brew_prefix="$(brew --prefix)"

	# If we're running from MacVim, don't bother with completions
	if [[ "$SHLVL" == '1' ]] && [[ -z "${TERM:-}" ]]; then
		BASH_COMPLETION_DISABLE=1
	fi

	if [[ -f "${brew_prefix}/share/bash-completion/bash_completion" ]] &&
		[[ -z "${BASH_COMPLETION_DISABLE:-}" ]]; then
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

unset BASH_COMPLETION_DISABLE
