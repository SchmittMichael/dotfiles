if not type -q fisher
  source ../fisher_init.fish
end


function __source
    # Using type instead of command allows for functions too
    if type -q $argv[1]
        $argv | source
    end
end

# loading .profile
bass source ~/.profile; or echo "Couldn't load `.profile`, bass isn't installed..."

# some sourcing
__source zoxide init fish 
functions -e __source
