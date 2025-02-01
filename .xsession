#!/bin/sh

setxkbmap fr -variant lafayette33

xsetroot -solid "#333333"

xclock -strftime '%a %d %b %H:%M' &
xbattbar -c &

for wm in openbsd-cwm cwm; do
    if command -v "$wm" >/dev/null 2>&1; then
        exec "$wm"
    fi
done

echo "Error: Neither 'cwm' nor 'openbsd-cwm' is installed." >&2
exit 1
