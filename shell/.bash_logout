# vim: ft=sh

# Git Bash sometimes won't close if any children (e.g. ssh-agent) are running
if [ "$OS" = 'Windows_NT' -a -n "$SSH_AGENT_PID" ]; then
  kill $SSH_AGENT_PID >/dev/null 2>&1
fi
