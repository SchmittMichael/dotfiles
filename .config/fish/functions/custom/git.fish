function gal
  set -l options (fish_opt --short p --long path --optional-val)
  argparse $options -- $argv
  or return 1

  set -l path '.'
  if set -q _flag_path[1]
    set path $_flag_path[-1]

  end

  if test (count $argv) -eq 0
    echo "[ERROR] Commit message is required."
    return 1
  end

  if not test -e "$path"
    echo "[ERROR] File or directory '$path' does not exist."
    return 1
  end

  set gal_script "$HOME/custom_scripts/git_all"
  if test -f  $gal_script
    bash $gal_script "$argv"
  else
    git add "$path"
    git commit -m "$argv"
    git push
  end
end

function glol
  git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"
end
