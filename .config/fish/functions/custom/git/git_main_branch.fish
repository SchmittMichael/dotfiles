function git_main_branch --description 'Return the main branch name of the current git repository'
    if not git rev-parse --is-inside-work-tree >/dev/null
        echo 'Not a git repository'
        return 1
    end

    set branch (git symbolic-ref refs/remotes/origin/HEAD)
    if test -n "$branch"
        echo (string replace -r '^refs/remotes/origin/' '' "$branch")
        return 0
    else
        echo 'Unable to determine main branch'
        return 1
    end
end
