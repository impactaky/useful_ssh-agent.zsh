
[ $USEFUL_SSHAGENT_SSHADD_COMMAND ] || export USEFUL_SSHAGENT_SSHADD_COMMAND='ssh-add'

if [[ -z $USEFUL_SSHAGENT_SOCK_PATH ]]; then
    if [[ $XDG_STATE_HOME ]]; then
	USEFUL_SSHAGENT_SOCK_DIR="$XDG_STATE_HOME/useful_ssh_agent"
    else
	USEFUL_SSHAGENT_SOCK_DIR="$HOME/.local/state/useful_ssh_agent"
    fi
    mkdir -p "$USEFUL_SSHAGENT_SOCK_DIR"
    export USEFUL_SSHAGENT_SOCK_PATH="$USEFUL_SSHAGENT_SOCK_DIR/ssh.sock"
fi

function useful_ssh_agent() {
    ssh-agent | grep SSH_AUTH_SOCK | sed -e 's/SSH_AUTH_SOCK=\(.*\);.\+/\1/g' | xargs -I {} ln -sf {} "$USEFUL_SSHAGENT_SOCK_PATH"
}

function check_ssh-agent_and_execute() {
    if [[ ! -e $(readlink "$USEFUL_SSHAGENT_SOCK_PATH") ]]; then
        useful_ssh_agent
        $USEFUL_SSHAGENT_SSHADD_COMMAND
    fi
}

if [[ -n "$SSH_AUTH_SOCK" && "$SSH_AUTH_SOCK" != "$USEFUL_SSHAGENT_SOCK_PATH" ]]; then
    ln -sf "$SSH_AUTH_SOCK" "$USEFUL_SSHAGENT_SOCK_PATH"
fi

export SSH_AUTH_SOCK="$USEFUL_SSHAGENT_SOCK_PATH"

alias ssh-agent=useful_ssh_agent
