set LAPTOP_USER "michael"
set LAPTOP_IP "192.168.178.67"
set HOST_IDENTIFIER "$LAPTOP_USER@$LAPTOP_IP"


function connect-to-laptop --description "Helper function to ssh to the WSL of my laptop, while disabling suspend for the time connected"
  set -l fish_exit_on_error true

  __run_on_laptop "powercfg -change standby-timeout-dc 0"
  __run_on_laptop "powercfg -change standby-timeout-ac 0"

  ssh "$HOST_IDENTIFER"

  __run_on_laptop "powercfg -change standby-timeout-dc 10"
  __run_on_laptop "powercfg -change standby-timeout-ac 15"
  
end

function __run_ps1_on_laptop --argument-name command
  ssh "$HOST_IDENTIFER" "powershell.exe -c '$command'"
end
