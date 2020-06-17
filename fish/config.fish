set PATH $PATH $HOME/bin

# Fish git prompt
set __fish_git_prompt_showcolorhints true
set __fish_git_prompt_color_branch a3be8c
set __fish_git_prompt_color_branch_detached red

set __fish_git_prompt_showdirtystate true
set __fish_git_prompt_char_dirtystate '●'
set __fish_git_prompt_char_stagedstate '●'
set __fish_git_prompt_color_dirtystate yellow
set __fish_git_prompt_color_stagedstate a3be8c

set __fish_git_prompt_showstashstate true
set __fish_git_prompt_char_stashstate '⚑'

set __fish_git_prompt_showuntrackedfiles true
set __fish_git_prompt_char_untrackedfiles '●'
set __fish_git_prompt_color_untrackedfiles red

set __fish_git_prompt_showupstream informative
set __fish_git_prompt_char_upstream_equal ''
set __fish_git_prompt_char_upstream_ahead (set_color a3be8c)' +'
set __fish_git_prompt_char_upstream_behind (set_color red)' -'
set __fish_git_prompt_color_upstream_done normal

# Set Nord Color Scheme
set -U fish_color_normal normal
set -U fish_color_command 81a1c1
set -U fish_color_quote a3be8c
set -U fish_color_redirection b48ead
set -U fish_color_end 88c0d0
set -U fish_color_error ebcb8b
set -U fish_color_selection white --bold --background=brblack
set -U fish_color_search_match bryellow --background=brblack
set -U fish_color_history_current --bold
set -U fish_color_operator 00a6b2
set -U fish_color_escape 00a6b2
set -U fish_color_cwd green
set -U fish_color_cwd_root red
set -U fish_color_valid_path --underline
set -U fish_color_autosuggestion 4c566a
set -U fish_color_user brgreen
set -U fish_color_host normal
set -U fish_color_cancel -r
set -U fish_pager_color_completion normal
set -U fish_pager_color_description B3A06D yellow
set -U fish_pager_color_prefix white --bold --underline
set -U fish_pager_color_progress brwhite --background=cyan
set -U fish_color_comment 434c5e
set -U fish_color_param eceff4
set -U fish_color_match --background=brblue
