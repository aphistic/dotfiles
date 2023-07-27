#!/bin/bash

if ! hash rustup; then
	echo "Installing Rust"
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

echo "Installing Go"
brew install go
