function __source
    # Using type instead of command allows for functions too
    if type -q $argv[1]
        $argv | source
    end
end

__source zoxide init fish
__source fzf --fish

set -g fish_key_bindings fish_vi_key_bindings

functions -e __source