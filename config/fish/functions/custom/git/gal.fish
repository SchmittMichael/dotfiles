function gal --description "Add, commit and push all files in the current or given directory"
    set -l options \
        (fish_opt --short p --long path --required-val) \
        (fish_opt --long no-copy) \
        (fish_opt --short a --long all)

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

    # git add handling
    if set -q _flag_all
        git add --all
    else
        git add "$path"
    end

    # git commit handling
    if $WORK_ENV
        gcan "$argv"
    else
        git commit -m "$argv"
    end

    # git push handling
    git push

    if not set -q _flag_no_copy
        git_copy_commit_hash
    end
end
