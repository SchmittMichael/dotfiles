function ___bind_both
    bind -M default $argv
    bind -M insert $argv
end

function fish_custom_key_bindings
    bind --erase --all --preset
    fish_vi_key_bindings --no-erase
    functions -q fish_prompt

    ___bind_both ctrl-backspace backward-kill-word
    ___bind_both \b backward-kill-word
    ___bind_both ctrl-delete kill-word
    ___bind_both \ck up-or-search
    ___bind_both \cj down-or-search
    ___bind_both shift-tab complete-and-search
end
