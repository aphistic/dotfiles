# Disable the default venv display override. This is here so I don't
# forget to do it elsewhere and it involves the prompt.
set -g VIRTUAL_ENV_DISABLE_PROMPT true

function fish_prompt --description 'Write out the prompt'
    echo "" # Add a blank line before the prompt

    set -l user_color af87ff
    set -l user_symbol \$
    if [ $USER = root ]
        set user_color d75f5f
        set user_symbol \#
    end

    echo -n -s [(set_color $user_color)$USER(set_color reset)@(set_color 5fafd7)(prompt_hostname)(set_color reset)]

    set -l git_prompt (fish_git_prompt "%s")
    if [ -n "$git_prompt" ]
        echo -n -s "[G:" $git_prompt (set_color reset) "]"
    end

    # Disable the default virtual env prompt
    if set -q VIRTUAL_ENV
        echo -n -s "[P:" (set_color a838a6) (basename $VIRTUAL_ENV) (set_color reset) "]"
    end

    echo "" # Finish the first line
    echo -s (prompt_pwd) " $user_symbol "
end
