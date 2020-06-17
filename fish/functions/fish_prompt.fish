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
        echo -n -s [$git_prompt]
    end

    echo "" # Finish the first line
    echo -s (set_color a3be8c) (prompt_pwd) (set_color reset) " $user_symbol "
end
