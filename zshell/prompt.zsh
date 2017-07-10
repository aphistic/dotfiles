autoload -Uz colors && colors

source ${0:a:h}/functions/git.zsh

# Repo stuff
repo_info() {
	git branch >/dev/null 2>/dev/null && echo "$(git_repo_info)" && return
	echo ""
}
git_repo_info() {
	ZSH_THEME_GIT_PROMPT_UNTRACKED="N"
	ZSH_THEME_GIT_PROMPT_ADDED="A"
	ZSH_THEME_GIT_PROMPT_MODIFIED="M"
	ZSH_THEME_GIT_PROMPT_RENAMED="R"
	ZSH_THEME_GIT_PROMPT_DELETED="D"
	ZSH_THEME_GIT_PROMPT_STASHED="S"
	ZSH_THEME_GIT_PROMPT_UNMERGED="X"
	ZSH_THEME_GIT_PROMPT_AHEAD="Y"
	ZSH_THEME_GIT_PROMPT_BEHIND="Z"
	ZSH_THEME_GIT_PROMPT_DIVERGED="V"

	GIT_STATUS=$(git_prompt_status)
	DISPLAY_STATUS="("
	DISPLAY_ICON=""

	BRANCH=$(git_current_branch)
	CHANGED_DISPLAY="%{$fg_bold[red]%}$BRANCH%{$reset_color%}"
	NORMAL_DISPLAY="%{$fg_bold[green]%}$BRANCH%{$reset_color%}"
	if $(echo "$GIT_STATUS" | grep 'A' &> /dev/null); then
		DISPLAY_STATUS="$DISPLAY_STATUS$CHANGED_DISPLAY"
		DISPLAY_ICON="%{$fg_bold[magenta]%}!%{$reset_color%}"
	elif $(echo "$GIT_STATUS" | grep 'N' &> /dev/null); then
		DISPLAY_STATUS="$DISPLAY_STATUS$CHANGED_DISPLAY"
	elif $(echo "$GIT_STATUS" | grep 'M' &> /dev/null); then
		DISPLAY_STATUS="$DISPLAY_STATUS$CHANGED_DISPLAY"
	elif $(echo "$GIT_STATUS" | grep 'R' &> /dev/null); then
		DISPLAY_STATUS="$DISPLAY_STATUS$CHANGED_DISPLAY"
	elif $(echo "$GIT_STATUS" | grep 'D' &> /dev/null); then
		DISPLAY_STATUS="$DISPLAY_STATUS$CHANGED_DISPLAY"
		DISPLAY_ICON="%{$fg_bold[magenta]%}!%{$reset_color%}"
	else
		DISPLAY_STATUS="$DISPLAY_STATUS$NORMAL_DISPLAY"
	fi
	if $(echo "$GIT_STATUS" | grep 'Y' &> /dev/null); then
		DISPLAY_ICON="%{$fg_bold[magenta]%}*%{$reset_color%}"
	fi
	DISPLAY_STATUS="$DISPLAY_STATUS$DISPLAY_ICON)"
	#DISPLAY_STATUS="$DISPLAY_STATUS$GIT_STATUS"

	echo "$DISPLAY_STATUS"
}

# Standard prompt stuff
who_prompt() {
    echo "%{$fg_bold[green]%}%n%{$reset_color%}@%{$fg_bold[magenta]%}%m%{$reset_color%}"
}

directory_name() {
    echo "%{$fg_bold[cyan]%}%~%{$reset_color%}"
}

LF=$'\n'
export PROMPT="$(who_prompt) $(directory_name) ${LF}$ "

precmd() {
    # Add a blank line before each prompt
    print ""

    # Resets the title after executing a command
    title "zsh" "%m" "%55<...<%~"
    set_rprompt
}

set_rprompt() {
    export RPROMPT="$(repo_info)"
}