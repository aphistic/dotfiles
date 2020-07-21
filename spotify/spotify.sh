#!/bin/sh
{{ if or (eq .Env.HM_TASK "kxdatlas") (eq .Env.HM_TASK "fate") }}
/usr/bin/spotify --force-device-scale-factor=1.75
{{ else }}
/usr/bin/spotify
{{ end }}
