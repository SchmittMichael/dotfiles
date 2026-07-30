function add_to_path --description "Prepends a directory to PATH if it exists"
    set -l dir (string trim --  $argv[1])

    if test -z "$dir"
        return
    end
    if string match -qr '^#' -- "$dir"
        return
    end

    set dir (string replace -r '^~' $HOME $dir)

    if test -d "$dir"
        set -gx PATH "$dir" $PATH
    else
        echo "[WARNING]: Tried adding '$dir' to \$PATH, but directory doesn't exist..."
    end
end

if not test -f "$__fish_config_dir/functions/fisher.fish"
    echo "[WARNING]: Detected that 'fisher' isn't installed. Assuming fish isn't properly set up. Run 'fisher-init' to complete setup."
end

if test -f "$HOME/.path_additions"
    while read -l path
        add_to_path $path
    end <~/.path_additions
else if type -q bass
    echo "[WARNING]: using .profile fallback instead of '.path_additions'"
    bass source "$HOME/.profile"
else
    echo "[ERROR]: Couldn't load additional path variables"
end
