function lss --description "List files sorted by size"
  command eza -lf --color=always --sort=size $argv
end
