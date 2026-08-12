set -l custom_function_dirs \
    "$__fish_config_dir/functions/custom/" \
    "$__fish_config_dir/functions/custom/eza" \
    "$__fish_config_dir/functions/custom/git" \
    "$__fish_config_dir/functions/custom/wsl"

for dir in $custom_function_dirs
    if test -d "$dir"; and not contains -- "$dir" $fish_function_path
        set -p fish_function_path "$dir"
    end
end
