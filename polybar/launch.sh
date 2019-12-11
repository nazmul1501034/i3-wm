#!/bin/bash
NC='\033[0m'
RED='\033[31m'
BLUE='\033[34m'



launch_bar() {
  MONITOR=$1 IFACE_ETH=${eth} IFACE_WLAN=${wlan} polybar "$2" &
}



# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

eth=$(ip link | grep -m 1 -E '\b(en)' | awk '{print substr($2, 1, length($2)-1)}')
wlan=$(ip link | grep -m 1 -E '\b(wl)' | awk '{print substr($2, 1, length($2)-1)}')
printf "Found network interfaces: ${BLUE}%s${NC} (eth), ${BLUE}%s${NC} (wlan)\\n" "${eth}" "${wlan}"

# Use newline as field separator for looping over lines
IFS=$'\n'


# Launch bar1 and bar2

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload top &
    MONITOR=$m polybar --reload bottom &
# uncomment the above line if you want to see bottom bar
  done
else
  polybar --reload top &
  polybar --reload bottom &
fi
# polybar example &
#polybar top-primary -r &
#polybar bottom-primary -r &
#polybar top-secondary -r &
#polybar bottom-secondary -r &

