
[ $USEFUL_SSHAGENT_SSHADD_COMMAND ] || export USEFUL_SSHAGENT_SSHADD_COMMAND='ssh-add'

function useful_ssh_agent() {
    ssh-agent | grep SSH_AUTH_SOCK | sed -e 's/SSH_AUTH_SOCK=\(.*\);.\+/\1/g' | xargs -I {} ln -sf {} ~/.ssh/ssh_sock
}

function check_ssh-agent_and_execute() {
    if [ ! -e $(readlink ~/.ssh/ssh_sock) ]; then
        useful_ssh_agent
        $USEFUL_SSHAGENT_SSHADD_COMMAND
    fi
}

export SSH_AUTH_SOCK=~/.ssh/ssh_sock

alias ssh-agent=useful_ssh_agent
