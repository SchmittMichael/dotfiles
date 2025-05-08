function __source
    # Using type instead of command allows for functions too
    if type -q $argv[1]
        $argv | source
    end
end

# loading .profile
bass source ~/.profile

# some sourcing
__source fzf --fish
__source zoxide init fish 
functions -e __source


set -g fish_key_bindings fish_vi_key_bindings
