#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

{{ if eq .Env.HM_TASK "akame" }}

polybar first &

{{ else if eq .Env.HM_TASK "aphng" }}

polybar first &
polybar second &
polybar third &
polybar fourth &

{{ else if eq .Env.HM_TASK "ace" }}

polybar first &
polybar second &
polybar third &

{{ end }}
