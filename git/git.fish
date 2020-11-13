# Git abbreviations
abbr ga 'git add'
abbr gc 'git commit -m'
abbr gco 'git checkout'
abbr gd 'git diff'
abbr gcom 'git checkout master'
abbr gp 'git push'
abbr gpl 'git pull'
abbr gs 'git status'
abbr gl 'git lg'

function gu_me
    git config user.name "Kristin Davidson"
    git config user.email "k@kxd.dev"
end

function gu_work
    git config user.name "Kristin Davidson"
    git config user.email "kdavidson@atlassian.com"
end
