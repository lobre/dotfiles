# this is done by ubuntu so keeping it this way
if [ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

# override ssh agent to use gpg agent
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

export EDITOR="kak"
export LESS="-R --mouse"
export PAGER="less"

export GOPATH="$HOME/go"
export GOROOT="/usr/local/go"

export PATH="$HOME/bin:$HOME/.local/bin:$GOROOT/bin:$GOPATH/bin:$PATH"
