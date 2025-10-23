function gal --description "Add, commit and push all files in the current or given directory"
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

function git_main_branch --description "Return the main branch name of the current git repository"
  if not git rev-parse --is-inside-work-tree > /dev/null
    echo "Not a git repository"
    return 1
  end

  set branch (git symbolic-ref refs/remotes/origin/HEAD)
  if test -n "$branch"
    echo (string replace -r '^refs/remotes/origin/' '' "$branch")
    return 0
  else
    echo "Unable to determine main branch"
    return 1
  end
end

function git_current_branch
  git branch --show-current
end

function gcom
  git checkout (git_main_branch)
end

function gmom
  git merge origin/(git_main_branch)
end

function gmum
  git merge upstream/(git_main_branch)
end

function groh
  git reset origin/(git_current_branch) --hard
end

function gtl --description 'List Git tags sorted by version, optionally filtered by prefix'
    set pattern "*"
    if test (count $argv) -gt 0
        set pattern "$argv[1]*"
    end
    git tag --sort=-v:refname -n --list $pattern
end
