set fish_greeting ""
# Commands to run in interactive sessions can go here
if status is-interactive

  # Load custom functions
  set -U fish_function_path $fish_function_path 
  for script in (find -L ~/.config/fish/functions/custom -type f -name "*.fish")
      source $script
  end


  # vi keybinds
  set -g fish_key_bindings fish_vi_key_bindings
end

