function add_to_path --description "Prepends a directory to PATH if it exists"
  set -l dir $argv[1]
  echo "Dir $dir"

  if test -d "$dir"
    set -gx PATH "$dir" $PATH
  end
end

if not type -q fisher
  echo "[WARNING]: Detected that 'fisher' isn't installed. Assuming fish isn't properly set up. Run 'fisher-init' to complete setup."
end


if test -f "$HOME/.path_additions"
  for path in (cat "$HOME/.path_additions")
    add_to_path $path
  end
else if type -q bass
  echo "[WARNING]: using .profile fallback instead of '.path_additions'"
  bass source "$HOME/.profile"
else
  echo "[ERROR]: Couldn't load additional path variables"
end
