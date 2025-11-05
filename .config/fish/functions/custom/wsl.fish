set LAPTOP_USER "michael"
set LAPTOP_IP "192.168.178.49"
set HOST_IDENTIFIER "$LAPTOP_USER@$LAPTOP_IP"


function connect-to-laptop --description "Helper function to ssh to the WSL of my laptop, while disabling suspend for the time connected"
  set -l fish_exit_on_error true

  echo "Disabling auto suspend..."
  __run_ps1_on_laptop "powercfg -change standby-timeout-dc 0"
  __run_ps1_on_laptop "powercfg -change standby-timeout-ac 0"

  ssh "$HOST_IDENTIFIER"

  echo "Enabling auto suspend..."
  __run_ps1_on_laptop "powercfg -change standby-timeout-dc 10"
  __run_ps1_on_laptop "powercfg -change standby-timeout-ac 15"
end

function __run_ps1_on_laptop --argument-name command
  ssh "$HOST_IDENTIFIER" "/mnt/c/Windows/System32/WindowsPowerShell/v1.0//powershell.exe  -c '$command'"
end
