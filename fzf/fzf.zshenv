# Setup fzf
# ---------
if [[ ! "$PATH" == *$HOME/.fzf/bin* ]]; then
    export PATH="$PATH:$HOME/.fzf/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" == *$HOME/.fzf/man* && -d "$HOME/.fzf/man" ]]; then
    export MANPATH="$MANPATH:$HOME/.fzf/man"
fi
