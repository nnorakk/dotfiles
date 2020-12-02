#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch principal polybar
polybar right -c $HOME/.config/polybar/config &

# Launch second polybar
if [[ $(xrandr -q | grep -w connected | wc -l) -eq 2 ]]; then
    polybar left -c $HOME/.config/polybar/config &
fi
