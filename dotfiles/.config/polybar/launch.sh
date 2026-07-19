#!/usr/bin/env sh

# Modulos por host: quasar (casa) nao mostra o consultaponto;
# darkstar (trabalho) usa o fallback do config.
case "$(hostname)" in
  quasar)
    export PB_BAR_RIGHT="pulseaudio memory cpu openvpn-isrunning internet-isup mouse-battery powermenu tray"
    export PB_BAR_LEFT="pulseaudio memory cpu openvpn-isrunning powermenu tray"
    ;;
esac

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
