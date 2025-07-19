#!/bin/sh

PLAN9=$HOME/src/github.com/9fans/plan9port export PLAN9
PATH=$PATH:$PLAN9/bin export PATH

setxkbmap fr -variant lafayette33

touchpad=$(xinput list --name-only | grep -i 'touchpad' | head -n1)

if [ -n "$touchpad" ]; then
    xinput set-prop "$touchpad" "libinput Tapping Enabled" 1
    xinput set-prop "$touchpad" "libinput Natural Scrolling Enabled" 1
fi

xrdb -merge $HOME/.Xresources

$HOME/bin/monitors
$HOME/bin/dim 2>/dev/null

# background services
nitrogen --restore &
unclutter -idle 3 &
fontsrv & # plan9 fonts

# dynamic configs
if [ -f "$HOME/.xsession.local" ]; then
   . $HOME/.xsession.local
fi

for wm in openbsd-cwm cwm; do
    if command -v "$wm" >/dev/null 2>&1; then
	exec "$wm"
    fi
done

echo "Error: Neither 'cwm' nor 'openbsd-cwm' is installed." >&2
exit 1
