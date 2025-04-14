#!/bin/sh

setxkbmap fr -variant lafayette33

touchpad=$(xinput list --name-only | grep -i 'touchpad' | head -n1)

if [ -n "$touchpad" ]; then
    xinput set-prop "$touchpad" "libinput Tapping Enabled" 1
    xinput set-prop "$touchpad" "libinput Natural Scrolling Enabled" 1
fi

nitrogen --restore &
statusbar &
unclutter -idle 3 &
picom &

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
