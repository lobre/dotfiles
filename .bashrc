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
alias cal='ncal -b'
alias run-iso='qemu-system-x86_64 -boot d -m 2048 -enable-kvm -vga virtio -net nic -net user -cpu host -display gtk,grab-on-hover=on -cdrom'

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

prompt_char() {
    git rev-parse --is-inside-work-tree > /dev/null 2>&1 || {
        echo '$ '
        return
    }

    git_branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    git_dirty=$(git status --porcelain 2>/dev/null)

    dirty_char=
    [ -n "$git_dirty" ] && dirty_char='*'

    case "$git_branch" in
        main|master) main_char='$' ;;
        *)           main_char='%' ;;
    esac

    echo "${dirty_char}${main_char} "
}

set_prompt() {
    prompt_dir=$(basename "$PWD")

    if [ "$TERM" != "dumb" ]; then
        prompt_dir="\[\e[1m\]$prompt_dir\[\e[0m\]"
    fi

    bat_stat=$(cat /sys/class/power_supply/BAT*/status 2>/dev/null | head -n1)
    bat_cap=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -n1)

    prompt_bat=""

    if [ -n "$bat_cap" ] && [ "$bat_stat" != "Full" ] && [ "$bat_stat" != "Not charging" ]; then
        prompt_bat="|${bat_cap}%"
    fi

    PS1="$(date +%-H:%M)$prompt_bat $prompt_dir $(prompt_char)"
}

PROMPT_COMMAND=set_prompt

# set terminal title to running command
if [ "$TERM" = "xterm-256color" ]; then
    trap 'echo -ne "\033]0;${PWD##*/}: (${BASH_COMMAND})\007"' DEBUG
fi

# reserve ctrl-s to bash history forward
stty -ixon

# dynamic configs
if [ -f "$HOME/.bashrc.local" ]; then
   . "$HOME/.bashrc.local"
fi
