# only for interactive shells.
[[ $- == *i* ]] || return

HISTFILESIZE=-1
HISTSIZE=-1

shopt -s histappend
shopt -s checkwinsize
shopt -s extglob
shopt -s globstar
shopt -s checkjobs

alias ls='ls --color'
alias run-iso='qemu-system-x86_64 -boot d -m 2048 -enable-kvm -vga virtio -net nic -net user -cpu host -display gtk,grab-on-hover=on -cdrom'

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# source the git-sh-prompt script dynamically
if [ -f "$(git --exec-path)/git-sh-prompt" ]; then
    . "$(git --exec-path)/git-sh-prompt"
fi

# Git prompt configs, see https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_STATESEPARATOR="|"

PS1='\[\033[1;32m\]\h\[\033[0m\]:\[\033[1;34m\]\W\[\033[0;33m\]$(__git_ps1 "(%s)")\[\033[0m\]\$ '

case "$TERM" in
xterm*)
    PS1="\[\e]0;\h: \W\a\]$PS1"
    ;;

# for instance acme win
dumb)
    PS1='$ '
    ;;
esac

# reserve ctrl-s to bash history forward
stty -ixon

# dynamic configs
if [ -f "$HOME/.bashrc.local" ]; then
   . $HOME/.bashrc.local
fi
