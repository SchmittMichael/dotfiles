function lh --description "List hidden directories"
  command eza -dl '.*' --group-directories-first $argv
end
