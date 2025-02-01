# my good old friends
mkdir -p bin doc src

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

[[ ":$PATH:" != *":$HOME/bin:"* ]] && export PATH="$PATH:$HOME/bin"
[[ ":$PATH:" != *":$HOME/.local/bin:"* ]] && export PATH="$PATH:$HOME/.local/bin"
[[ ":$PATH:" != *":$GOROOT/bin:"* ]] && export PATH="$PATH:$GOROOT/bin"
[[ ":$PATH:" != *":$GOPATH/bin:"* ]] && export PATH="$PATH:$GOPATH/bin"

$HOME/bin/load-projects
