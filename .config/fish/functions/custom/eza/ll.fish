function ll --description "List files in long format with directories first"
    command eza -l --group-directories-first $argv
end
