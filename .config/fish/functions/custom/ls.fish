function l
    eza -la
end

function lss
    eza -lf --color=always --sort=size
end

function ll
    eza -l --group-directories-first
end

function lda
    eza -lDa
end

function lf
    eza -lf --color=always
end


function lfa
    eza -lfa --color=always
end

function lh
    eza -dl .* --group-directories-first

end

function lt
    eza -al --sort=modified
end
