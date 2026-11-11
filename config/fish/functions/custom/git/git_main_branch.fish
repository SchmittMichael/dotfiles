function git_main_branch --description 'Return the main branch name of the current git repository'
    if not git rev-parse --is-inside-work-tree >/dev/null 2>&1
        echo 'Not a git repository' >&2
        return 1
    end

    set -l branch (git symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null)

    if test -n "$branch"
        string replace origin/ '' "$branch"
    else if git show-ref --verify --quiet refs/heads/main
        echo main
    else if git show-ref --verify --quiet refs/heads/master
        echo master
    else
        echo 'Unable to determine main branch' >&2
        return 1
    end
end
