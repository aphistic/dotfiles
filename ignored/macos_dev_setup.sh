#!/bin/bash

echo "Installing rtx"
brew install jdxcode/tap/rtx

rtx plugin add golang

if ! hash rustup; then
	echo "Installing Rust"
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
