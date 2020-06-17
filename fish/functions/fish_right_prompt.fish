function fish_right_prompt
    echo -n -s (set_color $fish_color_autosuggestion) (date +"%Y-%m-%d %I:%M:%S%p") (set_color reset)
end
