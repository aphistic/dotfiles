#!/bin/sh

{{ if eq .Env.HM_TASK "kxdatlas" }}
/usr/bin/spotify --force-device-scale-factor=1.75
{{ else }}
/usr/bin/spotify
{{ end }}
