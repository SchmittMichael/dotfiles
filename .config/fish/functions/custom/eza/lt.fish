function lt --description "List all files sorted by modification time"
  command eza -al --sort=modified $argv
end
