mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

mkdir ~/.cache/zoxide
zoxide init nushell --hook prompt | save -f ~/.cache/zoxide/init.nu