# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# User/local binaries in the PATH
export PATH=~/.local/bin:$PATH

# Disables command history sharing between terminals
unsetopt share_history

HISTSIZE=500000
SAVEHIST=100000

export EDITOR=vim

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(ssh dir vcs newline status)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
