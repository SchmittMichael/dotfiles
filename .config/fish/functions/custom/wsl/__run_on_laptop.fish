function __run_ps1_on_laptop --argument-name command
    ssh "$(__laptop_host)" "/mnt/c/Windows/System32/WindowsPowerShell/v1.0//powershell.exe -c '$command'"
end
