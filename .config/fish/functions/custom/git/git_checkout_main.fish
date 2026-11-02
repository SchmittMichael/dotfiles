function git_checkout_main
    git checkout (git_main_branch)
    if test -n "$(git remote)"
        git pull
    end
end
