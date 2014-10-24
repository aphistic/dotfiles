# From http://dotfiles.org/~_why/.zshrc
# Sets the window title nicely no matter where you are
function title() {
    print -Pn "\e]0;%n@%m: %~\a"
}

function chpwd() {
    print -Pn "\e]0;%n@%m: %~\a"
}

function preexec() {
    cmd=${(V)1//\%/\%\%}
    print -Pn "\e]0;$cmd\a"
}

