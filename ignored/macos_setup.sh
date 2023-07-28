#!/bin/bash

fqdn=$(hostname -f)
while [ $# -gt 0 ]; do
	case "$1" in
		--fqdn=*)
			fqdn="${1#*=}"
			;;
		*)
			printf "Invalid argument\n"
			exit 1;
	esac
	shift
done

if [ -z "${fqdn}" ]; then
	echo "fqdn must be provided"
fi

hostname=$(echo -n "${fqdn}" | awk -F. '{print $1}')

if [[ "${fqdn}" != "$(hostname -f)" ]]; then
	echo "Setting up hostname"
	sudo scutil --set HostName ${fqdn}
	sudo scutil --set LocalHostName ${hostname}
	sudo scutil --set ComputerName ${hostname}
	dscacheutil -flushcache
fi

if ! hash brew; then
	echo "Installing Homebrew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Installing utils from homebrew"
brew install \
	age \
	bitwarden-cli \
	chezmoi \
	firefox \
	fzf \
	neovim \
	ripgrep \
	starship \
	tmux \
	zoxide
brew install --cask \
	fig \
	wezterm

