if hash luarocks 2>/dev/null; then
    cd ~ # For some reason luarocks gives an error if this is run outside of the home
    eval `luarocks path`
fi
