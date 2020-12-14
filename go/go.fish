set -x PATH $HOME/go/bin $PATH /usr/local/go/bin
set -x GOPATH $HOME/go

{{ if eq .Env.HM_TASK "kxdatlas" }}

set -x GOPRIVATE 'bitbucket.org/bitbucket/*,bitbucket.org/hipchat/*'

{{ else }}

set -x GOPROXY https://athens.kxd.dev

{{ end }}
