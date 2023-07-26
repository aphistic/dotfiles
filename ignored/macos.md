# MacOS Install Script

Because Apple doesn't like making things fully scriptable...

Commands can be run via `macos_setup.sh`

## First Steps

### Change Hostname

Set the system hostname (fqdn):

```
$ sudo scutil --set HostName <new host name>
```

Set the local hostname (Bonjour, like <hostname>.local)
```
$ sudo scutil --set LocalHostName <new host name>
```

Set the friendly computer name:
```
$ sudo scutil --set ComputerName <new name>
```

Flush the DNS cache:
```
$ dscacheutil -flushcache
```

Restart the mac.

### Install Apps

- Install Firefox
- Install Alfred
- Install Homebrew

```
$ brew install fzf
$ brew install ripgrep
$ brew install chezmoi
$ brew install age
$ brew install bitwarden-cli
$ brew install starship
$ brew install --cask wezterm
```

- Install Wavebox

## Dev Tools
- Install VS Code
- Install GitKraken
- Install Docker

