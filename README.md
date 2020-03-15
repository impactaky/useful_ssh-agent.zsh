# useful_ssh-agent.zsh
Add ssh-agent checking to ssh commands

## usage

```
# USEFUL_SSHAGENT_SSHADD_COMMAND='ssh-add key'
# alias setup_ssh=check_ssh-agent_and_execute
alias ssh='check_ssh-agent_and_execute && ssh'
alias scp='check_ssh-agent_and_execute && scp'
alias rsync='check_ssh-agent_and_execute && rsync'
alias sshfs='check_ssh-agent_and_execute && sshfs'
```

## Explain

This plugin Create a symbolic link ~/.ssh/ssh_sock when ssh-agent.
check_ssh-agent_and_execute function check ssh_sock, and if killed, execute ssh-agent and ssh-add automatically.
The automatically executed ssh-add command can be changed with the `USEFUL_SSHAGENT_SSHADD_COMMAND` variable.

