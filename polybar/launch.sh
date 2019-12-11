#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

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

