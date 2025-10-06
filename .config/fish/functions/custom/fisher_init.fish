function fisher-init 
  set bindings_path "$__fish_config_dir/conf.d/keybinds.fish"
  set prompt_path "$__fish_config_dir/functions/fish_prompt.fish"

  curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

  fisher install IlanCosman/tide@v6
  fisher install edc/bass
  fisher install jhillyerd/plugin-git

  tide configure --auto --style=Lean --prompt_colors='True color' --show_time='24-hour format' --lean_prompt_height='Two lines' --prompt_connection=Disconnected --prompt_spacing=Compact --icons='Few icons' --transient=Yes


  # very stupid and desperate workaround to set ctrl+j as 'down-or-search' automatically
  if not grep $bindings_path $prompt_path
    echo "source $bindings_path" >> $prompt_path  
    exec fish
  end
end
