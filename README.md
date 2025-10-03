# Dotfiles

I use [chezmoi](https://www.chezmoi.io/) for my dotfiles. It's a pretty handy
tool to allow me to have a DRY-ish dotfiles that I can still customize for
various environments I use them in.

## Setup

### First Time

1. If you don't have `chezmoi` installed yet, do that. The dotfiles might try
   and install some utilities I use so there's a single `chezmoi init` that
   needs to be run to set up everything.
2. `chezmoi init git@github.com:aphistic/dotfiles.git` will clone the dotfiles
   repo and ask a few questions to set up the initial
   `~/.config/chezmoi/chezmoi.yaml` config without having to remember all the
   settings.

### Updates

1. `chezmoi update --init` will update from remote and also run through the init
   again in case there are any new config questions to answer.

## Good to Knows

### `remove_privatedata`

This is a private repo I use to store various settings I don't want bots to pick
up or environment details that probably shouldn't be public. It's formatted the
same as a regular `chezmoi` source, which is why it doesn't follow the
`external_` pattern recommended in the `chezmoi` docs. It uses the `remove_`
prefix instead so the directory itself isn't copied to my home directory.

My repo, for example, has a `.chezmoidata` directory in its root that has
various `blah.yaml` files with data used in the public templates.
