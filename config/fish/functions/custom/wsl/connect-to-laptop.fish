function connect-to-laptop --description "Helper function to ssh to the WSL of my laptop, while disabling suspend for the time connected"
    set -l fish_exit_on_error true
    set -l host_identifier (__laptop_host)

    if ! ssh -o BatchMode=yes -o ConnectTimeout=1 $host_identifier exit 2>/dev/null
        echo "Couldn't connect to laptop..."
        return 1
    end

    echo "Disabling auto suspend..."
    __run_ps1_on_laptop "powercfg -change standby-timeout-dc 0; powercfg -change standby-timeout-ac 0"

    ssh "$host_identifier"

    echo "Enabling auto suspend..."
    __run_ps1_on_laptop "powercfg -change standby-timeout-dc 10; powercfg -change standby-timeout-ac 15"
end
