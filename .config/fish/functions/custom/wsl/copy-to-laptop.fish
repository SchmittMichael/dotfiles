function copy-to-laptop --description "Copy files to my laptop using SCP"
    if test (count $argv) -lt 1
        echo "Usage: $(status function) <source> [destination]"
        return 1
    end

    set source $argv[1]
    set destination "~/Downloads"

    if test (count $argv) -ge 2
        set destination $argv[2]
    end

    scp -r $source (__laptop_host):$destination
end
