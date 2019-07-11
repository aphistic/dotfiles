# forked from the oh-my-zsh "steef" theme:

# prompt style and colors based on Steve Losh's Prose theme:
# https://github.com/sjl/oh-my-zsh/blob/master/themes/prose.zsh-theme
#
# vcs_info modifications from Bart Trojanowski's zsh prompt:
# http://www.jukie.net/bart/blog/pimping-out-zsh-prompt
#
# git untracked files modification from Brian Carper:
# https://briancarper.net/blog/570/git-info-in-your-zsh-prompt

export VIRTUAL_ENV_DISABLE_PROMPT=1

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('%F{blue}`basename $VIRTUAL_ENV`%f') '
}
PR_GIT_UPDATE=1

setopt prompt_subst

autoload -U add-zsh-hook
autoload -Uz vcs_info

#use extended color palette if available
if [[ $terminfo[colors] -ge 256 ]]; then
    turquoise="%F{81}"
    orange="%F{166}"
    purple="%F{135}"
    hotpink="%F{161}"
    limegreen="%F{118}"
else
    turquoise="%F{cyan}"
    orange="%F{yellow}"
    purple="%F{magenta}"
    hotpink="%F{red}"
    limegreen="%F{green}"
fi

# enable VCS systems you use
zstyle ':vcs_info:*' enable git svn

# check-for-changes can be really slow.
# you should disable it, if you work with large repositories
zstyle ':vcs_info:*:prompt:*' check-for-changes true

# set formats
# %b - branchname
# %u - unstagedstr (see below)
# %c - stagedstr (see below)
# %a - action (e.g. rebase-i)
# %R - repository path
# %S - path in the repository
PR_RST="%f"
FMT_BRANCH="(%{$turquoise%}%b%u%c${PR_RST})"
FMT_ACTION="(%{$limegreen%}%a${PR_RST})"
FMT_UNSTAGED="%{$orange%}●"
FMT_STAGED="%{$limegreen%}●"

zstyle ':vcs_info:*:prompt:*' unstagedstr   "${FMT_UNSTAGED}"
zstyle ':vcs_info:*:prompt:*' stagedstr     "${FMT_STAGED}"
zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}"
zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""


function aphistic_preexec {
    case "$2" in
        *git*)
            PR_GIT_UPDATE=1
            ;;
        *hub*)
            PR_GIT_UPDATE=1
            ;;
        *svn*)
            PR_GIT_UPDATE=1
            ;;
    esac
}
add-zsh-hook preexec aphistic_preexec

function aphistic_chpwd {
    PR_GIT_UPDATE=1
}
add-zsh-hook chpwd aphistic_chpwd

function git_st() {
    local ahead behind
    local -a gitstatus

    ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l | tr -d '[:space:]')
    (( $ahead )) && gitstatus+=( "%{$limegreen%}+${ahead}${PR_RST}" )

    behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l | tr -d '[:space:]')
        (( $behind )) && gitstatus+=( "%{$orange%}-${behind}${PR_RST}" )

    if [[ -z "${gitstatus}" ]]; then
        GIT_REMOTE_STATUS=""
    else
        GIT_REMOTE_STATUS=" ${gitstatus}"
    fi
}

function aphistic_precmd {
    if [[ -n "$PR_GIT_UPDATE" ]] ; then
        git_st

        # check for untracked files or updated submodules, since vcs_info doesn't
        if git ls-files --other --exclude-standard 2> /dev/null | grep -q "."; then
            PR_GIT_UPDATE=1
            FMT_BRANCH="(%{$turquoise%}%b%u%c%{$hotpink%}●${PR_RST}${GIT_REMOTE_STATUS})"
        else
            FMT_BRANCH="(%{$turquoise%}%b%u%c${PR_RST}${GIT_REMOTE_STATUS})"
        fi
        zstyle ':vcs_info:*:prompt:*' formats "${FMT_BRANCH} "

        vcs_info 'prompt'
        PR_GIT_UPDATE=
    fi

    if hash kubectl 2>/dev/null; then
        K8S_CUR_CONTEXT=`kubectl config current-context 2>/dev/null`
        if [ $? -eq 0 ]; then
            K8S_INFO="(%{$turquoise%}${K8S_CUR_CONTEXT}${PR_RST})"
        else
            K8S_INFO=""
        fi
    fi
}
add-zsh-hook precmd aphistic_precmd

PROMPT=$'
%{$turquoise%}%n${PR_RST}@%{$purple%}%m${PR_RST} %{$limegreen%}%~${PR_RST}
$ '
RPROMPT='$vcs_info_msg_0_$(virtualenv_info)${K8S_INFO}'
