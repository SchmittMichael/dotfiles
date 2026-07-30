function git_tag_list --description 'List Git tags sorted by version, optionally filtered by prefix'
    set pattern "*"
    if test (count $argv) -gt 0
        set pattern "$argv[1]*"
    end
    git tag --sort=-v:refname -n --list $pattern
end
