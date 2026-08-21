function __source_cmd
    if type -q $argv[1]
        $argv | source
    end
end

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

function main_init
    # default setup
    set -g fish_greeting ""

    if status is-interactive
        set -g fish_key_bindings fish_custom_key_bindings
    end

    # fisher check
    if not test -f "$__fish_config_dir/functions/fisher.fish"
        echo "[WARNING]: Detected that 'fisher' isn't installed. Assuming fish isn't properly set up. Run 'fisher-init' to complete setup."
    end

    # work env check
    if string match -rq '^anevis-admin:' </etc/passwd
        set -g WORK_ENV true
    else
        set -g WORK_ENV false
    end

    # path additions
    if test -f "$HOME/.path_additions"
        while read -l path
            add_to_path $path
        end <~/.path_additions
    else if type -q bass
        if status is-interactive
            echo "[WARNING]: using .profile fallback instead of '.path_additions'"
        end
        bass source "$HOME/.profile"
    else
        echo "[ERROR]: Couldn't load additional path variables"
    end

    # external programs fish compatibility
    __source_cmd zoxide init fish
    __source_cmd fzf --fish
end

main_init
