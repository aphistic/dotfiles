#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

polybar first &
polybar second &
polybar third &

{{ if eq .Env.HM_TASK "aphng" }}

polybar fourth &

{{ end }}
