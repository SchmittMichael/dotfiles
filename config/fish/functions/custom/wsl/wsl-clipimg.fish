function wsl-clipimg --description "Copy a WSL image to the Windows clipboard"
    if test (count $argv) -eq 0
        echo "Error: Please provide a path to an image file."
        return 1
    end
    set file_path $argv[1]

    if not test -f $file_path
        echo "Error: File '$file_path' does not exist."
        return 1
    end

    powershell.exe -command "Set-Clipboard -Path $(wslpath -w $file_path[1])"
end
