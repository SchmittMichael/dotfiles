function lt --description "List all files sorted by modification time"
    command eza -al --group-directories-first --sort=modified $argv
end
