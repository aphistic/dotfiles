#!/bin/bash

echo "Installing mise"
brew install jdxcode/tap/mise

mise plugin add golang

if ! hash rustup; then
	echo "Installing Rust"
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
