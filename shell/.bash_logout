#!/usr/bin/env bash
# shellcheck disable=SC1090

if [[ -f "${HOME}/.bash_logout.local" ]]; then
	. "${HOME}/.bash_logout.local"
fi

# Clear the terminal title on logout/ssh disconnect
printf '\033]0;\007'
