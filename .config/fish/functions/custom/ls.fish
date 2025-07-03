function l
    eza -la $argv
end

function lss
    eza -lf --color=always --sort=size $argv
end

function ll
    eza -l --group-directories-first $argv
end

function lda
    eza -lDa $argv
end

function lf
    eza -lf --color=always $argv
end


function lfa
    eza -lfa --color=always $argv
end

function lh
    eza -dl .* --group-directories-first $argv

end

function lt
    eza -al --sort=modified $argv
end
