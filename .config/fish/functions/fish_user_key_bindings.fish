function __source
  if type -q $argv[1]
    $argv | source
  end
end

function fish_user_key_bindings
  __source zoxide init fish
  __source fzf --fish

  # remvoe fzf shift-tab overwrite
  bind -M insert shift-tab complete-and-search
  bind shift-tab complete-and-search

  functions -e __source
end
