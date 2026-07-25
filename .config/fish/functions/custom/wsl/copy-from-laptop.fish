function copy-from-laptop --description "Copy files from my laptop to my desktop using SCP"
  if test (count $argv) -lt 1
    echo "Usage: $(status function) <source> [destination]"
    return 1
  end

  set source $argv[1]
  set destination "."

  if test (count $argv) -ge 2
    set destination $argv[2]
  end

  scp -r (__laptop_host):$source $destination
end
