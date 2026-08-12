function git_copy_commit_hash --description "Copies the latest commit hash of the current branch to the clipboard"
    set -l commit_hash (git rev-parse HEAD 2>/dev/null)

    if test $status -ne 0
        echo "[ERROR]: Not inside a Git repository!" >&2
        return 1
    end

    clipboard_copy "$commit_hash"
end
