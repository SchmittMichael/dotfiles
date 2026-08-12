function clipboard_copy --description "Copies input text to an available clipboard provider"
    if test (count $argv) -gt 0
        printf '%s' "$argv"
    else
        cat
    end | begin
        if type -q wl-copy
            wl-copy
        else if type -q xsel
            xsel --clipboard --input
        else
            echo "[ERROR]: No available clipboard provider!" >&2
            return 1
        end
    end
end
